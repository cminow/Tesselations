//
//  EastWestHexagonsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/22/25.
//

import SwiftUI

struct EastWestHexagonsView: View {
    var hexRadius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in

                let rows = size.height / hexRadius
                let columns = (size.width * 1.5) / hexRadius
                var brightness: Double = 0.0

                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0

                        if column % 2 != 0 {
                            columnOffset = hexRadius * sqrt(3) / 2.0
                        }
                        let center = CGPoint(x: Double(column) * hexRadius * 1.5, y: Double(row) * hexRadius * sqrt(3) + columnOffset)

                        let mainPath: Path = hexPath(radius: hexRadius, center: center)
                        brightness = .random(in: 0.50...0.750)
                        context.fill(mainPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: brightness)))
                        context.stroke(mainPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: 0.45)), lineWidth: 1.0)
                    }
                }
            }
        }
    }

    func hexPath(radius: CGFloat, center: CGPoint) -> Path {
        var path = Path()
        path.move(to: hexagonCorner(center: center, radius: radius, cornerIndex: 0))
        for index in 1...5 {
            path.addLine(to: hexagonCorner(center: center, radius: radius, cornerIndex: index))
        }
        path.closeSubpath()
        return path
    }
    
    func hexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angle: CGFloat = (CGFloat(60).radians * CGFloat(cornerIndex))
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }
}

#Preview {
    EastWestHexagonsView(hexRadius: 16.0)
}
