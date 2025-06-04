//
//  TwelvePointStarView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/3/25.
//

import SwiftUI

struct TwelvePointStarView: View {
    var radius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = (size.height * 1.5) / radius
                let columns: CGFloat = size.width / radius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0

                        if row % 2 != 0 {
                            rowOffset = radius * .sqrt3 / 2.0
                        }
                        let center = CGPoint(x: Double(column) * radius * sqrt(3.0) + rowOffset, y: Double(row) * radius * 1.5)

                        var layoutHexagons: [Hexagon] = []
                        for layoutFactor: CGFloat in stride(from: 1.0, to: 0.0, by: -0.2) {
                            let hexagon: Hexagon = Hexagon(center: center, radius: radius * layoutFactor, direction: .northSouth)
                            layoutHexagons.append(hexagon)
                            context.stroke(hexagon.path, with: .color(.black), style: .init(lineWidth: 1.0, lineCap: .round, lineJoin: .round))
                        }
                        let innerHex = layoutHexagons[layoutHexagons.count - 1]
                        context.fill(innerHex.inscribedSixPointStarPath, with: .color(.black))
                        let secondStar = Hexagon(center: center, radius: innerHex.radius, direction: .eastWest)
                        context.fill(secondStar.inscribedSixPointStarPath, with: .color(.black))
                    }
                }
            }
        }
    }
}

#Preview {
    TwelvePointStarView(radius: 128)
}
