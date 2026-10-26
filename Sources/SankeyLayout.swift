import SwiftUI

struct SankeyLayout {
    private(set) var nodes: [Node] = []
    private(set) var links: [Link] = []
    private(set) var labelWidth = 0.0
    private var indices: [String: Int] = [:]
    private let size: CGSize
    private let nodeWidth: Double
    private let labelPadding: Double
    private var spacing: Double

    init(_ data: SankeyData, options: SankeyOptions, size: CGSize) throws(Error) {
        self.size = size
        nodeWidth = options.nodeWidth
        labelPadding = options.labelPadding
        spacing = options.nodePadding
        try addNodes(data.nodes)
        try addLinks(data.links)
        try computeRanks()
        var columns = computeColumns(alignment: options.nodeAlignment)
        computeLabelWidth()
        computeBreadths(&columns)
        computeLinkEnds()
    }

    // MARK: - Graph

    private mutating func addNodes(_ dataNodes: [SankeyNode]) throws(Error) {
        for node in dataNodes {
            guard indices[node.id] == nil else { throw .duplicateNode(node.id) }
            indices[node.id] = nodes.count
            nodes.append(
                Node(index: nodes.count, id: node.id, label: node.label, color: node.color)
            )
        }
    }

    private mutating func addLinks(_ dataLinks: [SankeyLink]) throws(Error) {
        for link in dataLinks {
            guard link.value.isFinite, link.value >= 0 else { throw .invalidValue(link.value) }
            guard let source = indices[link.source] else { throw .missingNode(link.source) }
            guard let target = indices[link.target] else { throw .missingNode(link.target) }
            nodes[source].sourceLinks.append(links.count)
            nodes[target].targetLinks.append(links.count)
            links.append(
                Link(source: source, target: target, value: link.value, color: link.color)
            )
        }
        for i in nodes.indices {
            let outgoing = nodes[i].sourceLinks.reduce(0) { $0 + links[$1].value }
            let incoming = nodes[i].targetLinks.reduce(0) { $0 + links[$1].value }
            nodes[i].value = max(outgoing, incoming)
        }
    }

    private mutating func computeRanks() throws(Error) {
        let depths = ranks(following: \.sourceLinks, to: \.target)
        let heights = ranks(following: \.targetLinks, to: \.source)
        guard let depths, let heights else { throw .circularLink }
        for i in nodes.indices {
            nodes[i].depth = depths[i]
            nodes[i].height = heights[i]
        }
    }

    private func ranks(
        following nodeLinks: KeyPath<Node, [Int]>, to end: KeyPath<Link, Int>
    ) -> [Int]? {
        var ranks = Array(repeating: 0, count: nodes.count)
        var current = Set(nodes.indices)
        var rank = 0
        while !current.isEmpty {
            var next = Set<Int>()
            for i in current {
                ranks[i] = rank
                next.formUnion(nodes[i][keyPath: nodeLinks].map { links[$0][keyPath: end] })
            }
            rank += 1
            guard rank <= nodes.count else { return nil }
            current = next
        }
        return ranks
    }

    // MARK: - Columns

    private mutating func computeColumns(alignment: SankeyNodeAlignment) -> [[Int]] {
        let count = (nodes.map(\.depth).max() ?? 0) + 1
        let columnSpacing = (size.width - nodeWidth) / Double(count - 1)
        var columns = Array(repeating: [Int](), count: count)
        for i in nodes.indices {
            let aligned = column(of: nodes[i], alignment: alignment, count: count)
            let layer = max(0, min(count - 1, aligned))
            nodes[i].layer = layer
            nodes[i].x0 = Double(layer) * columnSpacing
            nodes[i].x1 = nodes[i].x0 + nodeWidth
            columns[layer].append(i)
        }
        return columns.filter { !$0.isEmpty }
    }

    private func column(of node: Node, alignment: SankeyNodeAlignment, count: Int) -> Int {
        switch alignment {
        case .left:
            return node.depth
        case .right:
            return count - 1 - node.height
        case .justify:
            return node.sourceLinks.isEmpty ? count - 1 : node.depth
        case .center:
            if !node.targetLinks.isEmpty { return node.depth }
            let depths = node.sourceLinks.map { nodes[links[$0].target].depth }
            return (depths.min() ?? 1) - 1
        }
    }

    // MARK: - Breadths

    private mutating func computeBreadths(_ columns: inout [[Int]]) {
        let tallest = columns.map(\.count).max() ?? 1
        spacing = min(spacing, size.height / 2 / Double(max(tallest - 1, 1)))
        initializeBreadths(columns)
        let iterations = 6
        for i in 0..<iterations {
            let alpha = pow(0.99, Double(i))
            let beta = max(1 - alpha, Double(i + 1) / Double(iterations))
            relaxRightToLeft(&columns, alpha: alpha, beta: beta)
            relaxLeftToRight(&columns, alpha: alpha, beta: beta)
        }
    }

    private mutating func initializeBreadths(_ columns: [[Int]]) {
        let scale = valueScale(columns)
        for column in columns {
            var y = 0.0
            for i in column {
                nodes[i].y0 = y
                nodes[i].y1 = y + nodes[i].value * scale
                y = nodes[i].y1 + spacing
                for link in nodes[i].sourceLinks {
                    links[link].width = links[link].value * scale
                }
            }
            let gap = (size.height - y + spacing) / Double(column.count + 1)
            for (offset, i) in column.enumerated() {
                nodes[i].y0 += gap * Double(offset + 1)
                nodes[i].y1 += gap * Double(offset + 1)
            }
            for i in column {
                sortSourceLinks(of: i)
                sortTargetLinks(of: i)
            }
        }
    }

    private func valueScale(_ columns: [[Int]]) -> Double {
        let scales = columns.map { column in
            let total = column.reduce(0) { $0 + nodes[$1].value }
            return (size.height - Double(column.count - 1) * spacing) / total
        }
        return scales.filter(\.isFinite).min() ?? 0
    }

    private mutating func relaxLeftToRight(_ columns: inout [[Int]], alpha: Double, beta: Double) {
        for c in columns.indices.dropFirst() {
            for target in columns[c] {
                var y = 0.0
                var w = 0.0
                for link in nodes[target].targetLinks {
                    let source = links[link].source
                    let v = links[link].value * Double(nodes[target].layer - nodes[source].layer)
                    y += targetTop(source: source, target: target) * v
                    w += v
                }
                guard w > 0 else { continue }
                shift(target, by: (y / w - nodes[target].y0) * alpha)
            }
            sortAndResolve(&columns[c], alpha: beta)
        }
    }

    private mutating func relaxRightToLeft(_ columns: inout [[Int]], alpha: Double, beta: Double) {
        for c in columns.indices.dropLast().reversed() {
            for source in columns[c] {
                var y = 0.0
                var w = 0.0
                for link in nodes[source].sourceLinks {
                    let target = links[link].target
                    let v = links[link].value * Double(nodes[target].layer - nodes[source].layer)
                    y += sourceTop(source: source, target: target) * v
                    w += v
                }
                guard w > 0 else { continue }
                shift(source, by: (y / w - nodes[source].y0) * alpha)
            }
            sortAndResolve(&columns[c], alpha: beta)
        }
    }

    private mutating func shift(_ i: Int, by dy: Double) {
        nodes[i].y0 += dy
        nodes[i].y1 += dy
        for link in nodes[i].targetLinks {
            sortSourceLinks(of: links[link].source)
        }
        for link in nodes[i].sourceLinks {
            sortTargetLinks(of: links[link].target)
        }
    }

    private mutating func sortAndResolve(_ column: inout [Int], alpha: Double) {
        column.sort { nodes[$0].y0 < nodes[$1].y0 }
        let middle = column.count / 2
        let subject = nodes[column[middle]]
        pushUp(column, from: subject.y0 - spacing, at: middle - 1, alpha: alpha)
        pushDown(column, from: subject.y1 + spacing, at: middle + 1, alpha: alpha)
        pushUp(column, from: size.height, at: column.count - 1, alpha: alpha)
        pushDown(column, from: 0, at: 0, alpha: alpha)
    }

    private mutating func pushDown(
        _ column: [Int], from start: Double, at index: Int, alpha: Double
    ) {
        var y = start
        for i in column[max(index, 0)...] {
            let dy = (y - nodes[i].y0) * alpha
            if dy > 1e-6 {
                nodes[i].y0 += dy
                nodes[i].y1 += dy
            }
            y = nodes[i].y1 + spacing
        }
    }

    private mutating func pushUp(
        _ column: [Int], from start: Double, at index: Int, alpha: Double
    ) {
        guard index >= 0 else { return }
        var y = start
        for i in column[...index].reversed() {
            let dy = (nodes[i].y1 - y) * alpha
            if dy > 1e-6 {
                nodes[i].y0 -= dy
                nodes[i].y1 -= dy
            }
            y = nodes[i].y0 - spacing
        }
    }

    private mutating func sortSourceLinks(of i: Int) {
        var sorted = nodes[i].sourceLinks
        sorted.sort { (nodes[links[$0].target].y0, $0) < (nodes[links[$1].target].y0, $1) }
        nodes[i].sourceLinks = sorted
    }

    private mutating func sortTargetLinks(of i: Int) {
        var sorted = nodes[i].targetLinks
        sorted.sort { (nodes[links[$0].source].y0, $0) < (nodes[links[$1].source].y0, $1) }
        nodes[i].targetLinks = sorted
    }

    private func targetTop(source: Int, target: Int) -> Double {
        var y = nodes[source].y0 - Double(nodes[source].sourceLinks.count - 1) * spacing / 2
        for link in nodes[source].sourceLinks {
            if links[link].target == target { break }
            y += links[link].width + spacing
        }
        for link in nodes[target].targetLinks {
            if links[link].source == source { break }
            y -= links[link].width
        }
        return y
    }

    private func sourceTop(source: Int, target: Int) -> Double {
        var y = nodes[target].y0 - Double(nodes[target].targetLinks.count - 1) * spacing / 2
        for link in nodes[target].targetLinks {
            if links[link].source == source { break }
            y += links[link].width + spacing
        }
        for link in nodes[source].sourceLinks {
            if links[link].target == target { break }
            y -= links[link].width
        }
        return y
    }

    private mutating func computeLinkEnds() {
        for i in nodes.indices {
            var sourceY = nodes[i].y0
            var targetY = nodes[i].y0
            for link in nodes[i].sourceLinks {
                links[link].sourceY = sourceY + links[link].width / 2
                sourceY += links[link].width
            }
            for link in nodes[i].targetLinks {
                links[link].targetY = targetY + links[link].width / 2
                targetY += links[link].width
            }
        }
    }

    // MARK: - Geometry

    private mutating func computeLabelWidth() {
        let columns = Set(nodes.map(\.x0)).sorted()
        let gaps = zip(columns.dropFirst(), columns).map { $0 - $1 }
        let span = ([size.width / 2] + gaps).min() ?? 0
        labelWidth = max(0, span - nodeWidth - 2 * labelPadding)
    }

    func path(for link: Link) -> Path {
        let start = CGPoint(x: nodes[link.source].x1, y: link.sourceY)
        let end = CGPoint(x: nodes[link.target].x0, y: link.targetY)
        let middle = (start.x + end.x) / 2
        var path = Path()
        path.move(to: start)
        path.addCurve(
            to: end,
            control1: CGPoint(x: middle, y: start.y),
            control2: CGPoint(x: middle, y: end.y)
        )
        return path
    }

    func isLeading(_ node: Node) -> Bool {
        node.x0 < (size.width / 2)
    }

    func labelCenter(for node: Node) -> CGPoint {
        let offset = labelPadding + (labelWidth / 2)
        let x = isLeading(node) ? (node.x1 + offset) : (node.x0 - offset)
        return CGPoint(x: x, y: node.rect.midY)
    }

    func node(at point: CGPoint) -> Node? {
        nodes.first { node in
            let dx = min(0, (node.rect.width - 44) / 2)
            let dy = min(0, (node.rect.height - 44) / 2)
            return node.rect.insetBy(dx: dx, dy: dy).contains(point)
        }
    }

    func highlight(_ id: String?) -> Highlight {
        let index = id.flatMap { indices[$0] }
        let touching = links.filter { ($0.source == index) || ($0.target == index) }
        return Highlight(
            id: index.map { nodes[$0].id },
            index: index,
            connected: Set(touching.flatMap { [$0.source, $0.target] })
        )
    }

    enum Error: Swift.Error {
        case circularLink
        case duplicateNode(String)
        case invalidValue(Double)
        case missingNode(String)
    }

    struct Node: Identifiable {
        let index: Int
        let id: String
        let label: String?
        let color: Color?
        var value = 0.0
        var depth = 0
        var height = 0
        var layer = 0
        var x0 = 0.0
        var x1 = 0.0
        var y0 = 0.0
        var y1 = 0.0
        var sourceLinks: [Int] = []
        var targetLinks: [Int] = []

        var rect: CGRect {
            CGRect(x: x0, y: y0, width: x1 - x0, height: y1 - y0)
        }
    }

    struct Link {
        let source: Int
        let target: Int
        let value: Double
        let color: Color?
        var width = 0.0
        var sourceY = 0.0
        var targetY = 0.0
    }

    struct Highlight {
        let id: String?
        let index: Int?
        let connected: Set<Int>

        func touches(_ link: Link) -> Bool {
            (index == nil) || (link.source == index) || (link.target == index)
        }

        func isLit(_ node: Node) -> Bool {
            (index == nil) || (node.index == index) || connected.contains(node.index)
        }
    }
}
