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
                        
                        let backgroundHexagon = hexPath(radius: radius, center: center)
                        context.fill(backgroundHexagon, with: .color(.green))
                        
                        let innerMostHex = hexPath(radius: radius / 5.0, center: center)
                        context.fill(innerMostHex, with: .color(.blue))

                        let firstMiddleTrapezoidPaths = middleTrapezoidPaths(center: center, radius: radius, startCornerIndex: 0)
                        for path in firstMiddleTrapezoidPaths {
                            context.fill(path, with: .color(.red))
                        }

                        let secondMiddleTrapezoidPaths = middleTrapezoidPaths(center: center, radius: radius, startCornerIndex: 3)
                        for path in secondMiddleTrapezoidPaths {
                            context.fill(path, with: .color(.yellow))
                        }

                        let innerCornerCapsPaths = innerCornerCaps(center: center, radius: radius)
                        for path in innerCornerCapsPaths {
                            context.fill(path, with: .color(.purple))
                        }

                        let outerTrapezoidsPaths = outerTrapezoids(center: center, radius: radius,startCornerIndex: 1)
                        for path in outerTrapezoidsPaths {
                            context.fill(path, with: .color(red: 0.0, green: 0.5, blue: 1.0))
                        }

                        let secondOuterTrapezoidPaths = outerTrapezoids(center: center, radius: radius, startCornerIndex: 4)
                        for path in secondOuterTrapezoidPaths {
                            context.fill(path, with: .color(red: 0.50, green: 1.0, blue: 1.0))
                        }
                        
                        // Stroke the outlines here so it's always on top:
                        context.stroke(backgroundHexagon, with: .color(.gray), style: strokeStyle)
                        context.stroke(innerMostHex, with: .color(.gray), style: strokeStyle)
                        for path in firstMiddleTrapezoidPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }
                        for path in secondMiddleTrapezoidPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }
                        for path in innerCornerCapsPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }

                        for path in outerTrapezoidsPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }
                    }
                }
            }
        }
    }

    private func outerTrapezoids(center: CGPoint, radius: CGFloat, startCornerIndex: Int) -> [Path] {
        var paths: [Path] = []

        var centerPoints: [CGPoint] = []
        for index in 0...5 {
            centerPoints.append(northSouthHexagonCorner(center: center,
                                                        radius: radius * sqrt(0.48),
                                                        cornerIndex: index))
        }

        for index in 0...5 {
            var path: Path = Path()
            path.move(to: hexagonCorner(center: centerPoints[index],
                                        radius: radius / 5.0,
                                        cornerIndex: (startCornerIndex + index) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                           radius: radius / 5.0,
                                           cornerIndex: (startCornerIndex + index + 1) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                           radius: radius / 5.0,
                                           cornerIndex: (startCornerIndex + index + 2) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                           radius: radius / 5.0,
                                           cornerIndex: (startCornerIndex + index + 3) % 6))
            path.closeSubpath()
            paths.append(path)
        }
        
        return paths
    }
    
    private func innerCornerCaps(center: CGPoint, radius: CGFloat) -> [Path] {
        var paths: [Path] = []
        
        var centerPoints: [CGPoint] = []
        for index in 0...5 {
            centerPoints.append(hexagonCorner(center: center,
                                              radius: (radius / 5.0) * 3.0,
                                              cornerIndex: index))
        }

        for index in 0...5 {
            var path = Path()
            path.move(to: hexagonCorner(center: centerPoints[index],
                                        radius: radius / 5.0,
                                        cornerIndex: index % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                        radius: radius / 5.0,
                                        cornerIndex: (index + 1) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                        radius: radius / 5.0,
                                        cornerIndex: (index + 2) % 6))
            path.addLine(to: centerPoints[index])
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                           radius: radius / 5.0,
                                           cornerIndex: (index + 4) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                           radius: radius / 5.0,
                                           cornerIndex: (index + 5) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                        radius: radius / 5.0,
                                        cornerIndex: index % 6))
            path.closeSubpath()
            paths.append(path)
        }
        
        return paths
    }
    
    private func middleTrapezoidPaths(center: CGPoint, radius: CGFloat, startCornerIndex: Int) -> [Path] {
        var paths: [Path] = []

        var centerPoints: [CGPoint] = []
        for index in 0...5 {
            centerPoints.append(hexagonCorner(center: center,
                                              radius: radius / 2.5,
                                              cornerIndex: index))
        }

        for index in 0...5 {
            var path: Path = Path()
            path.move(to: hexagonCorner(center: centerPoints[index],
                                        radius: radius / 5.0,
                                        cornerIndex: (startCornerIndex + index) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                           radius: radius / 5.0,
                                           cornerIndex: (startCornerIndex + index + 1) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
                                           radius: radius / 5.0,
                                           cornerIndex: (startCornerIndex + index + 2) % 6))
            path.addLine(to: hexagonCorner(center: centerPoints[index],
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

    private func northSouthHexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
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
    MoreHexagons(radius: 128.0)
}
