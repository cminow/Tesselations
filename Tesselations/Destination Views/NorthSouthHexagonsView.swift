//
//  NorthSouthHexagonsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/22/25.
//

import SwiftUI

struct NorthSouthHexagonsView: View {
    let hexRadius: CGFloat = 16.0

    var body: some View {
        VStack {
            Canvas { context, size in

                let rows = (size.height * 1.5) / hexRadius
                let columns = size.width / hexRadius
                var brightness: Double = 0.0

                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0

                        if row % 2 != 0 {
                            rowOffset = hexRadius * sqrt(3.0) / 2.0
                        }
                        let center = CGPoint(x: Double(column) * hexRadius * sqrt(3.0) + rowOffset, y: Double(row) * hexRadius * 1.5)

                        let mainPath: Path = hexPath(radius: hexRadius, row: row, column: column, center: center)
                        brightness = .random(in: 0.50...0.750)
                        context.fill(mainPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: brightness)))
                    }
                }
            }
        }
    }

    func hexPath(radius: CGFloat, row: Int, column: Int, center: CGPoint) -> Path {
        var path = Path()
        path.move(to: hexagonCorner(center: center, radius: radius, cornerIndex: 0))
        for index in 1...5 {
            path.addLine(to: hexagonCorner(center: center, radius: radius, cornerIndex: index))
        }
        path.closeSubpath()
        return path
    }
    
    func hexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angleDegrees: CGFloat = (60.0 * CGFloat(cornerIndex)) - 30.0
        let angleRadians: CGFloat = .pi / 180.0 * angleDegrees
        let corner = CGPoint(
            x: center.x + radius * cos(angleRadians),
            y: center.y + radius * sin(angleRadians)
        )
        return corner
    }
}

#Preview {
    NorthSouthHexagonsView()
}
