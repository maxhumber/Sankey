import XCTest
@testable import Sankey

final class SankeyFlowTests: XCTestCase {
    func testFlowAsString() throws {
        let flow = SankeyLink(source: "A", target: "B", weight: 3)
        XCTAssertEqual("\(flow)", "['A', 'B', 3.0]")
    }
    
    func testFlowsAsString() throws {
        let flow = SankeyLink(source: "A", target: "B", weight: 3)
        let flows = [flow, flow]
        XCTAssertEqual("\(flows)", "['A', 'B', 3.0]")
    }
    
    func testExampleA() {
        let options = SankeyOptions()
        print(options)
    }
}
