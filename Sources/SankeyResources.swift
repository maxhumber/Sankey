import Foundation

struct SankeyResources {
    static let d3minjs: String = loadResource(named: "d3.min", type: "js")
    static let d3sankeyminjs: String = loadResource(named: "d3-sankey.min", type: "js")
    
    private static func loadResource(named name: String, type: String) -> String {
        guard let path = Bundle.module.path(forResource: name, ofType: type), let content = try? String(contentsOfFile: path) else {
            print("\(name).\(type) not found in the bundle")
            return ""
        }
        return content
    }
}
