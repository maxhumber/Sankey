import Testing
@testable import Sankey

struct SankeyTests {
    @Test func testLinkAsString() {
        let link = SankeyLink(source: "A", target: "B", value: 3)
        #expect(String(describing: link) == "['A', 'B', 3.0]")
    }
}
