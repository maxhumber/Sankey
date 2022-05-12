import XCTest
@testable import Sankey

final class SankeyTests: XCTestCase {
    func testLinkExpressibleByArrayLiteral() {
        XCTAssertNoThrow {
            let _: SankeyLink = ["Foo", "Bar", "3"]
        }
    }
    
    func testLinkAsString() {
        let link = SankeyLink(source: "A", target: "B", value: 3)
        XCTAssertEqual("\(link)", "['A', 'B', 3.0]")
    }

    func testLinksAsString() {
        let links: [SankeyLink] = [["A", "X", "5"], ["A", "Y", "7"]]
        XCTAssertEqual("\(links)", "[['A', 'X', 5.0], ['A', 'Y', 7.0]]")
    }
    
    func testSankeyOptions() {
        let options = SankeyOptions()
        let defaults = """
            {
              "tooltip" : {
                "valueLabel" : "",
                "textStyle" : {
                  "fontSize" : 40,
                  "bold" : false,
                  "italic" : false,
                  "color" : "black"
                },
                "showColorCode" : false,
                "isHtml" : false
              },
              "sankey" : {
                "link" : {
                  "color" : {
                    "strokeWidth" : 0
                  }
                },
                "iterations" : 32,
                "node" : {
                  "colorMode" : "unique",
                  "label" : {
                    "fontSize" : 40,
                    "bold" : false,
                    "italic" : false,
                    "color" : "black"
                  },
                  "interactivity" : false
                }
              },
              "forceIFrame" : false
            }
            """
        XCTAssertEqual("\(options)", defaults)
    }
}
