//
//  MoreHexagons.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/27/25.
//

import SwiftUI

struct MoreHexagons: View {
    var radius: CGFloat
    let strokeStyle: StrokeStyle = .init(lineWidth: 2.0, lineCap: .round, lineJoin: .round)

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0

                        if column % 2 != 0 {
                            columnOffset = radius * sqrt(3) / 2.0
                        }

                        let center = CGPoint(x: Double(column) * radius * 1.5, y: Double(row) * radius * sqrt(3) + columnOffset)
                        
                        let innerMostHex = hexPath(radius: radius / 5.0, center: center)
                        context.fill(innerMostHex, with: .color(.blue))

                        let firstMiddleRhombusPaths = middleRhombusPaths(center: center, radius: radius, startCornerIndex: 0)
                        for path in firstMiddleRhombusPaths {
                            context.fill(path, with: .color(.red))
                        }

                        let secondMiddleRhombusPaths = middleRhombusPaths(center: center, radius: radius, startCornerIndex: 3)
                        for path in secondMiddleRhombusPaths {
                            context.fill(path, with: .color(.yellow))
                        }
                        
                        context.stroke(innerMostHex, with: .color(.gray), style: strokeStyle)
                        for path in firstMiddleRhombusPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }
                    }
                }
            }
        }
    }

    private func middleRhombusPaths(center: CGPoint, radius: CGFloat, startCornerIndex: Int) -> [Path] {
        var paths: [Path] = []

        var centerPoints: [CGPoint] = []
        for index in 0...5 {
            centerPoints.append(hexagonCorner(center: center,
                                              radius: radius / 2.55,
                                              cornerIndex: index))
        }

        for index in 0...5 {
            var path: Path = Path()
            path.move(to: hexagonCorner(center: centerPoints[index % 6],
                                        radius: radius / 5.0,
                                        cornerIndex: (startCornerIndex + index) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index % 6],
                                           radius: radius / 5.0,
                                           cornerIndex: (startCornerIndex + index + 1) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index % 6],
                                           radius: radius / 5.0,
                                           cornerIndex: (startCornerIndex + index + 2) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index % 6],
                                           radius: radius / 5.0,
                                           cornerIndex: (startCornerIndex + index + 3) % 6))
            path.closeSubpath()
            paths.append(path)
            
        }
        return paths
    }

    private func hexPath(radius: CGFloat, center: CGPoint) -> Path {
        var path = Path()
        path.move(to: hexagonCorner(center: center, radius: radius, cornerIndex: 0))
        for index in 1...5 {
            path.addLine(to: hexagonCorner(center: center, radius: radius, cornerIndex: index))
        }
        path.closeSubpath()
        return path
    }
    
    private func hexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angleDegrees: CGFloat = (60.0 * CGFloat(cornerIndex))
        let angleRadians: CGFloat = .pi / 180.0 * angleDegrees
        let corner = CGPoint(
            x: center.x + radius * cos(angleRadians),
            y: center.y + radius * sin(angleRadians)
        )
        return corner
    }
}

#Preview {
    MoreHexagons(radius: 128.0)
}
