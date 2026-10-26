import Foundation
import Testing

@testable import Sankey

struct SankeyLayoutTests {
    @Test
    func rejectsCyclesMissingAndDuplicateNodes() {
        let cycle = SankeyData(
            nodes: [SankeyNode("a"), SankeyNode("b")],
            links: [SankeyLink(1, from: "a", to: "b"), SankeyLink(1, from: "b", to: "a")]
        )
        let missing = SankeyData(
            nodes: [SankeyNode("a")], links: [SankeyLink(1, from: "a", to: "b")]
        )
        let duplicate = SankeyData(
            nodes: [SankeyNode("a"), SankeyNode("a")], links: [SankeyLink(1, from: "a", to: "a")]
        )
        for data in [cycle, missing, duplicate] {
            #expect(throws: SankeyLayout.Error.self) {
                try SankeyLayout(
                    data, options: SankeyOptions(), size: CGSize(width: 100, height: 100))
            }
        }
    }

    @Test
    func highlightsConnectedFlowsAndHitsBars() throws {
        let data = SankeyData(
            nodes: [SankeyNode("a"), SankeyNode("b"), SankeyNode("x"), SankeyNode("y")],
            links: [SankeyLink(1, from: "a", to: "x"), SankeyLink(1, from: "b", to: "y")]
        )
        let layout = try SankeyLayout(
            data, options: SankeyOptions(), size: CGSize(width: 400, height: 200))
        let highlight = layout.highlight("a")
        #expect(layout.links.map(highlight.touches) == [true, false])
        #expect(layout.nodes.map(highlight.isLit) == [true, false, true, false])
        #expect(layout.highlight("missing").id == nil)
        let a = layout.nodes[0]
        #expect(layout.node(at: CGPoint(x: a.rect.midX, y: a.rect.midY))?.id == "a")
        #expect(layout.node(at: layout.labelCenter(for: a)) == nil)
        #expect(layout.node(at: CGPoint(x: 200, y: 100)) == nil)
    }

    @Test
    func fitsInBoundsAndConservesFlow() throws {
        let data = SankeyData(
            nodes: ["design", "build", "test", "web", "api", "app", "prod"].map { SankeyNode($0) },
            links: [
                SankeyLink(30, from: "design", to: "web"),
                SankeyLink(20, from: "design", to: "app"),
                SankeyLink(40, from: "build", to: "web"),
                SankeyLink(60, from: "build", to: "api"),
                SankeyLink(30, from: "build", to: "app"),
                SankeyLink(25, from: "test", to: "web"),
                SankeyLink(35, from: "test", to: "api"),
                SankeyLink(15, from: "test", to: "app"),
                SankeyLink(95, from: "web", to: "prod"),
                SankeyLink(95, from: "api", to: "prod"),
                SankeyLink(65, from: "app", to: "prod"),
            ]
        )
        let size = CGSize(width: 400, height: 300)
        let layout = try SankeyLayout(data, options: SankeyOptions(), size: size)
        let bounds = CGRect(origin: .zero, size: size).insetBy(dx: -1e-6, dy: -1e-6)
        let scale = layout.nodes[0].rect.height / layout.nodes[0].value
        for node in layout.nodes {
            #expect(bounds.contains(node.rect), "\(node.id) in bounds")
            #expect(abs(node.rect.height - node.value * scale) < 1e-6, "\(node.id) height")
            let outgoing = node.sourceLinks.reduce(0) { $0 + layout.links[$1].width }
            let incoming = node.targetLinks.reduce(0) { $0 + layout.links[$1].width }
            #expect(abs(max(outgoing, incoming) - node.rect.height) < 1e-6, "\(node.id) flow")
        }
        let columns = Dictionary(grouping: layout.nodes, by: \.x0).values
        for column in columns {
            let stacked = column.sorted { $0.y0 < $1.y0 }
            for (upper, lower) in zip(stacked, stacked.dropFirst()) {
                let gap = lower.y0 - upper.y1
                #expect(gap >= SankeyOptions().nodePadding - 1e-6, "\(upper.id) above \(lower.id)")
            }
        }
    }

    @Test
    func alignmentPlacesNodes() throws {
        let data = SankeyData(
            nodes: ["a", "b", "c", "d", "x", "y"].map { SankeyNode($0) },
            links: [
                SankeyLink(4, from: "a", to: "b"),
                SankeyLink(3, from: "b", to: "c"),
                SankeyLink(5, from: "c", to: "d"),
                SankeyLink(2, from: "x", to: "c"),
                SankeyLink(1, from: "b", to: "y"),
            ]
        )
        // Late source `x` and early sink `y` share a column with the named node.
        let expected: [SankeyNodeAlignment: (x: String, y: String)] = [
            .left: ("a", "c"), .right: ("b", "d"), .center: ("b", "c"), .justify: ("a", "d"),
        ]
        for (alignment, columns) in expected {
            var options = SankeyOptions()
            options.nodeAlignment = alignment
            let size = CGSize(width: 400, height: 200)
            let layout = try SankeyLayout(data, options: options, size: size)
            let x0 = Dictionary(uniqueKeysWithValues: layout.nodes.map { ($0.id, $0.x0) })
            #expect(x0["x"] == x0[columns.x], "\(alignment) x")
            #expect(x0["y"] == x0[columns.y], "\(alignment) y")
        }
    }

    @Test
    func rejectsNegativeAndNonFiniteValues() {
        for value in [-1, .infinity, .nan] {
            let data = SankeyData(
                nodes: [SankeyNode("a"), SankeyNode("b")],
                links: [SankeyLink(value, from: "a", to: "b")]
            )
            #expect(throws: SankeyLayout.Error.self) {
                try SankeyLayout(
                    data, options: SankeyOptions(), size: CGSize(width: 100, height: 100))
            }
        }
    }

    @Test
    func zeroValuesStayFinite() throws {
        let data = SankeyData(
            nodes: [SankeyNode("a"), SankeyNode("b")], links: [SankeyLink(0, from: "a", to: "b")]
        )
        let layout = try SankeyLayout(
            data, options: SankeyOptions(), size: CGSize(width: 100, height: 100))
        #expect(layout.nodes.allSatisfy { $0.y0.isFinite && $0.y1.isFinite })
    }

    @Test
    func crowdedColumnsKeepHeight() throws {
        let sources = (1...6).map { "s\($0)" }
        let data = SankeyData(
            nodes: (sources + ["sink"]).map { SankeyNode($0) },
            links: sources.map { SankeyLink(1, from: $0, to: "sink") }
        )
        let layout = try SankeyLayout(
            data, options: SankeyOptions(), size: CGSize(width: 300, height: 100))
        #expect(layout.nodes.allSatisfy { $0.rect.height > 0 })
    }
}
