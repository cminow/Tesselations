//
//  TrianglesView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/22/25.
//

// This is based on code from hexagons, since they're closely related.

import SwiftUI

struct TrianglesView: View {
    var hexRadius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows = size.height / hexRadius
                let columns = (size.width * 1.5) / hexRadius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0

                        if column % 2 != 0 {
                            columnOffset = hexRadius * sqrt(3) / 2.0
                        }
                        let center = CGPoint(x: Double(column) * hexRadius * 1.5, y: Double(row) * hexRadius * sqrt(3) + columnOffset)
                        for index in 0...5 {
                            let mainPath: Path = trianglePath(hexCenter: center, radius: hexRadius, cornerIndex: index)
                            let brightness: Double = .random(in: 0.50...0.750)
                            context.fill(mainPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: brightness)))
                        }
                    }
                }
            }
        }
    }

    func trianglePath(hexCenter: CGPoint, radius: CGFloat, cornerIndex: Int) -> Path {
        var path = Path()
        path.move(to: hexagonCorner(center: hexCenter, radius: radius, cornerIndex: cornerIndex))
        path.addLine(to: hexagonCorner(center: hexCenter, radius: radius, cornerIndex: cornerIndex + 1))
        path.addLine(to: hexCenter)
        path.closeSubpath()
        return path
    }
    
    func hexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angleDegrees: CGFloat = (60.0 * CGFloat(cornerIndex))// - 30.0
        let angleRadians: CGFloat = .pi / 180.0 * angleDegrees
        let corner = CGPoint(
            x: center.x + radius * cos(angleRadians),
            y: center.y + radius * sin(angleRadians)
        )
        return corner
    }
}

#Preview {
    TrianglesView(hexRadius: 32.0)
}
