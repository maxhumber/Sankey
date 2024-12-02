//
//  RussianView.swift
//  Examples
//
//  Created by Max Humber on 2024-12-02.
//

import SwiftUI
import Sankey

struct RussianView: View {
    let data = SankeyData(
        nodes: [
            SankeyNode("A"),
            SankeyNode("Здоровʼя"),
            SankeyNode("B")
        ],
        links: [
            SankeyLink(5, from: "Здоровʼя", to: "B"),
            SankeyLink(10, from: "A", to: "B")
        ]
    )
    
    var body: some View {
        SankeyDiagram(data)
            .padding(10)
            .frame(height: 250)
    }
}

#Preview {
    RussianView()
}
