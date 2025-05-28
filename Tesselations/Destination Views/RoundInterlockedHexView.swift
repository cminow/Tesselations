//
//  RoundInterlockedHexView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/26/25.
//

import SwiftUI

struct RoundInterlockedHexView: View {
    var hexRadius: CGFloat
    let strokeStyle: StrokeStyle = .init(lineWidth: 2.0, lineCap: .round, lineJoin: .round)
    let colors: [GraphicsContext.Shading] = [.color(.red), .color(.yellow), .color(.blue)]

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

                        let paths = paths(center: center, radius: hexRadius)
                        
                        for (index, path) in paths.enumerated() {
                            context.fill(path, with: colors[index % colors.count])
                        }

                        for path in paths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }
                    }
                }
            }
        }
    }

    private func paths(center: CGPoint, radius: CGFloat) -> [Path] {
        let innerHexRadius: CGFloat = radius / 2.0
        var innerHexCenters: [CGPoint] = []
        
        var paths: [Path] = []
        
        for index in 0...5 {
            innerHexCenters.append(hexagonCorner(center: center, radius: innerHexRadius, cornerIndex: index))
        }

        for index in 0...5 {
            var path = Path()
            path.move(to: center)
            path.addLine(to: hexagonCorner(center: innerHexCenters[index % 6],
                                           radius: innerHexRadius,
                                           cornerIndex: (index + 4) % 6))
            path.addLine(to: hexagonCorner(center: innerHexCenters[index % 6],
                                           radius: innerHexRadius,
                                           cornerIndex: (index + 5) % 6))
            path.addLine(to: hexagonCorner(center: innerHexCenters[index % 6],
                                           radius: innerHexRadius,
                                           cornerIndex: index % 6))
            path.addLine(to: hexagonCorner(center: innerHexCenters[index % 6],
                                           radius: innerHexRadius,
                                           cornerIndex: (index + 1) % 6))
            path.addLine(to: innerHexCenters[index % 6])
            path.addLine(to: center)
            path.closeSubpath()
            
            paths.append(path)
        }

        return paths
    }
    
    private func hexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
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
    RoundInterlockedHexView(hexRadius: 32.0)
}
