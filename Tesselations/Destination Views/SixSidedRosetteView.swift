//
//  SixSidedRosetteView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/26/25.
//

import SwiftUI

struct SixSidedRosetteView: View {
    var hexRadius: CGFloat
    let strokeStyle: StrokeStyle = .init(lineWidth: 2.0, lineCap: .round, lineJoin: .round)

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / hexRadius
                let columns: CGFloat = size.width / hexRadius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0

                        if column % 2 != 0 {
                            columnOffset = hexRadius * sqrt(3) / 2.0
                        }

                        let center = CGPoint(x: Double(column) * hexRadius * 1.5, y: Double(row) * hexRadius * sqrt(3) + columnOffset)

                        let paths = centralPetalPaths(center: center, outerRadius: hexRadius)
                        
                        for (index, path) in paths.enumerated() {
                            if index % 2 == 0 {
                                context.fill(path, with: .color(red: 1.0, green: 0.0, blue: 0.0))
                            } else {
                                context.fill(path, with: .color(red: 0.70, green: 0.0, blue: 0.0))
                            }
                        }

                        let trapezoidPaths: [Path] = middleTrapezoidPaths(center: center, outerRadius: hexRadius)

                        for (index, path) in trapezoidPaths.enumerated() {
                            if index % 2 == 0 {
                                context.fill(path, with: .color(red: 0.0, green: 0.0, blue: 1.0))
                            } else {
                                context.fill(path, with: .color(red: 0.0, green: 0.0, blue: 0.5))
                            }
                            
                        }

                        let outerPetalPaths: [Path] = cornerPetalPaths(center: center, outerRadius: hexRadius)
                        
                        for (index, path) in outerPetalPaths.enumerated() {
                            if index % 2 == 0 {
                                context.fill(path, with: .color(red: 0.2, green: 0.50, blue: 0.0))
                            } else {
                                context.fill(path, with: .color(red: 0.2, green: 0.70, blue: 0.0))
                            }
                            
                        }

                        let outerTrapezoidPetalPaths: [Path] = outerEdgeTrapezoidPaths(center: center, outerRadius: hexRadius)
                        
                        for (index, path) in outerTrapezoidPetalPaths.enumerated() {
                            if index % 2 == 0 {
                                context.fill(path, with: .color(red: 0.90, green: 0.90, blue: 0.0))
                            } else {
                                context.fill(path, with: .color(red: 1.0, green: 0.70, blue: 0.0))
                            }
                        }

                        let fillerTriangles: [Path] = triangleFillers(center: center, outerRadius: hexRadius)
                        
                        for (index, path) in fillerTriangles.enumerated() {
                            if index % 2 == 0 {
                                context.fill(path, with: .color(red: 1.0, green: 0.50, blue: 1.0))
                            } else {
                                context.fill(path, with: .color(red: 0.80, green: 0.0, blue: 0.80))
                            }
                            
                        }
                        
                        // Stroke everything once we've filled in the rest.
                        for path in paths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }

                        for path in trapezoidPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }

                        for path in outerPetalPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }

                        for path in outerTrapezoidPetalPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }

                        for path in fillerTriangles {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }
                    }
                }
            }
        }
    }

    private func outerEdgeTrapezoidPaths(center: CGPoint, outerRadius: CGFloat) -> [Path] {
        var paths: [Path] = []
        var hexCenters: [CGPoint] = []

        let newRadius: CGFloat = outerRadius / 4.05
        for index in 0...5 {
            hexCenters.append(northSouthHexagonCorner(center: center, radius: newRadius * 3.5, cornerIndex: index))
        }

        for index in 0...5 {
            var path = Path()
            path.move(to: eastWestHexagonCorner(center: hexCenters[index], radius: newRadius, cornerIndex: (index + 2) % 6))
            path.addLine(to: eastWestHexagonCorner(center: hexCenters[index], radius: newRadius, cornerIndex: (index + 3) % 6))
            path.addLine(to: eastWestHexagonCorner(center: hexCenters[index], radius: newRadius, cornerIndex: (index + 4) % 6))
            path.addLine(to: eastWestHexagonCorner(center: hexCenters[index], radius: newRadius, cornerIndex: (index + 1) % 6))
            path.closeSubpath()
            paths.append(path)
        }
        
        return paths
    }

    private func triangleFillers(center: CGPoint, outerRadius: CGFloat) -> [Path] {
        var paths: [Path] = []

        var centerPoints: [CGPoint] = []
        let newRadius: CGFloat = outerRadius / 4.0

        for index in 0...5 {
            centerPoints.append(northSouthHexagonCorner(center: center, radius: newRadius * 1.75, cornerIndex: index))
        }
        
        for index in 0...5 {
            var path = Path()
            path.move(to: centerPoints[index])
            for _ in 0...2 {
                path.addLine(to: eastWestHexagonCorner(center: centerPoints[index],
                                                       radius: newRadius,
                                                       cornerIndex: index % 6))
                path.addLine(to: eastWestHexagonCorner(center: centerPoints[index],
                                                       radius: newRadius,
                                                       cornerIndex: (index + 5) % 6))
            }
            path.closeSubpath()
            paths.append(path)
        }
        
        return paths
    }
    
    private func middleTrapezoidPaths(center: CGPoint, outerRadius: CGFloat) -> [Path] {
        var paths: [Path] = []
        
        var centerPoints: [CGPoint] = []
        let newRadius: CGFloat = outerRadius / 4.0

        for index in 0...5 {
            centerPoints.append(eastWestHexagonCorner(center: center, radius: newRadius * 2.0, cornerIndex: index))
        }

        for index in 0...5 {
            var path: Path = Path()
            var path1: Path = Path()
            path.move(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: index % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 1) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 2) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 3) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 0) % 6))
            path.closeSubpath()
            paths.append(path)

            path1.move(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: index % 6))
            path1.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 3) % 6))
            path1.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 4) % 6))
            path1.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 5) % 6))
            path1.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 0) % 6))
            path1.closeSubpath()
            paths.append(path1)
        }
        
        
        return paths
    }
    
    private func centralPetalPaths(center: CGPoint, outerRadius: CGFloat) -> [Path] {
        var paths: [Path] = []
        var innerRadiusPoints: [CGPoint] = []
        var petalPointRadiusPoints: [CGPoint] = []
        
        let newRadius: CGFloat = outerRadius / 4.0
        for index in 0...5 {            
            innerRadiusPoints.append(eastWestHexagonCorner(center: center, radius: newRadius, cornerIndex: index))
            petalPointRadiusPoints.append(northSouthHexagonCorner(center: center, radius: newRadius * 1.75, cornerIndex: index))
        }

        for index in 0...5 {
            var path: Path = Path()
            path.move(to: center)
            path.addLine(to: innerRadiusPoints[(index + 5) % 6])
            path.addLine(to: petalPointRadiusPoints[index % 6])
            path.addLine(to: innerRadiusPoints[index % 6])
            path.addLine(to: center)
            path.closeSubpath()
            paths.append(path)
        }

        return paths
    }

    private func cornerPetalPaths(center: CGPoint, outerRadius: CGFloat) -> [Path] {
        var paths: [Path] = []
        
        var centerPoints: [CGPoint] = []
        let newRadius: CGFloat = outerRadius * 0.25

        for index in 0...5 {
            centerPoints.append(eastWestHexagonCorner(center: center, radius: newRadius * 3.0, cornerIndex: index))
        }
        
        for index in 0...5 {
            var path: Path = Path()
            var path1: Path = Path()
            path.move(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (5 + index % 6)))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (0 + index % 6)))
            path.addLine(to: centerPoints[index % 6])
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (4 + index % 6)))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (5 + index % 6)))
            path.closeSubpath()
            paths.append(path)

            path1.move(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (1 + index % 6)))
            path1.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (2 + index % 6)))
            path1.addLine(to: centerPoints[index % 6])
            path1.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (0 + index % 6)))
            path1.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (1 + index % 6)))
            path1.closeSubpath()
            paths.append(path1)
        }
        
        return paths
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

    func eastWestHexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
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
    SixSidedRosetteView(hexRadius: 64)
}
