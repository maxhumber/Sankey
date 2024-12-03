import Foundation
import Testing
import SwiftUI
@testable import Sankey

struct SankeyTests {
    @Test func testMultipleLinks() {
        let links = [
            SankeyLink(1, from: "A", to: "B"),
            SankeyLink(2, from: "B", to: "C"),
            SankeyLink(3, from: "A", to: "C")
        ]
        #expect(links.count == 3)
        #expect(links[0].value == 1)
        #expect(links[1].target == "C")
        #expect(links[2].source == "A")
    }

    @Test func testSankeyNodeEncoding() {
        let node = SankeyNode("A", label: "Node A", color: .red)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        let data = try! encoder.encode(node)
        let jsonString = String(data: data, encoding: .utf8)!
        #expect(jsonString == "{\"hex\":{\"dark\":\"#FF4539\",\"light\":\"#FF3A2F\"},\"id\":\"A\",\"label\":\"Node A\"}")
    }

    @Test func testSankeyLinkEncoding() {
        let link = SankeyLink(5, from: "A", to: "B", color: .blue)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        let data = try! encoder.encode(link)
        let jsonString = String(data: data, encoding: .utf8)!
        #expect(jsonString == "{\"hex\":{\"dark\":\"#0A83FF\",\"light\":\"#007AFF\"},\"source\":\"A\",\"target\":\"B\",\"value\":5}")
    }

    @Test func testSankeyDataEncoding() {
        let node = SankeyNode("A")
        let link = SankeyLink(5, from: "A", to: "B")
        let data = SankeyData(nodes: [node], links: [link])
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        let dataEncoded = try! encoder.encode(data)
        let jsonString = String(data: dataEncoded, encoding: .utf8)!
        #expect(jsonString.contains("\"nodes\":["))
        #expect(jsonString.contains("\"links\":["))
    }

    @Test func testHexColorConversion() {
        let color = Color.red
        let hexColor = HexColor(color)
        #expect(hexColor.light == "#FF3A2F")
        #expect(hexColor.dark == "#FF4539")
    }

    @Test func testSankeyNodeHexColor() {
        let node = SankeyNode("A", color: .green)
        let hex = node.hex
        #expect(hex?.light == "#33C758")
        #expect(hex?.dark == "#2FD157")
    }

    @Test func testSankeyLinkHexColor() {
        let link = SankeyLink(5, from: "A", to: "B", color: .blue)
        let hex = link.hex
        #expect(hex?.light == "#007AFF")
        #expect(hex?.dark == "#0A83FF")
    }

    @Test func testSankeyResourcesLoading() {
        let d3minjs = SankeyResources.d3minjs
        let d3sankeyminjs = SankeyResources.d3sankeyminjs
        #expect(!d3minjs.isEmpty)
        #expect(!d3sankeyminjs.isEmpty)
    }
}
