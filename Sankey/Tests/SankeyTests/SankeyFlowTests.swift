import XCTest
@testable import Sankey

final class SankeyFlowTests: XCTestCase {
    func testLinkAsString() {
        let link = SankeyLink(source: "A", target: "B", value: 3)
        XCTAssertEqual("\(link)", "['A', 'B', 3.0]")
    }
    
    func testLinksAsString() {
        let links: [SankeyLink] = [["A", "X", "5"], ["A", "Y", "7"]]
        XCTAssertEqual("\(links)", "[['A', 'X', 5.0], ['A', 'Y', 7.0]]")
    }
    
    func testExampleA() {
        let options = SankeyOptions()
        print(options)
    }
}
