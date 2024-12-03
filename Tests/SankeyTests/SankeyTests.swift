import Testing
@testable import Sankey

struct SankeyTests {
    @Test
    func testLinkAsString() {
        let link = SankeyLink(source: "A", target: "B", value: 3)
        #expect(String(describing: link) == "['A', 'B', 3.0]")
    }

    @Test
    func testLinksAsString() {
        let links: [SankeyLink] = [["A", "X", "5"], ["A", "Y", "7"]]
        #expect(String(describing: links) == "[['A', 'X', 5.0], ['A', 'Y', 7.0]]")
    }
}
