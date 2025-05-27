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
                        
                        for path in paths {
                            context.fill(path, with: .color(.red))
                        }

                        let rhombusPaths: [Path] = middleRhombusPaths(center: center, outerRadius: hexRadius)

                        for path in rhombusPaths {
                            context.fill(path, with: .color(.blue))
                        }

                        let outerPetalPaths: [Path] = cornerPetalPaths(center: center, outerRadius: hexRadius)
                        
                        for path in outerPetalPaths {
                            context.fill(path, with: .color(.green))
                        }

                        let outerRhombusPetalPaths: [Path] = outerEdgeRhombusPaths(center: center, outerRadis: hexRadius)
                        
                        for path in outerRhombusPetalPaths {
                            context.fill(path, with: .color(.yellow))
                        }
                        
                        // Stroke everything once we've filled in the rest.
                        for path in paths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }

                        for path in rhombusPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }

                        for path in outerPetalPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }

                        for path in outerRhombusPetalPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }
                    }
                }
            }
        }
    }

    private func outerEdgeRhombusPaths(center: CGPoint, outerRadis: CGFloat) -> [Path] {
        var paths: [Path] = []
        var hexCenters: [CGPoint] = []

        let newRadius: CGFloat = hexRadius / 4.0
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
    
    private func middleRhombusPaths(center: CGPoint, outerRadius: CGFloat) -> [Path] {
        var paths: [Path] = []
        
        var centerPoints: [CGPoint] = []
        let newRadius: CGFloat = outerRadius / 4.0

        for index in 0...5 {
            centerPoints.append(eastWestHexagonCorner(center: center, radius: newRadius * 2.0, cornerIndex: index))
        }

        for index in 0...5 {
            var path: Path = Path()
            path.move(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: index % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 1) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 2) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 3) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 0) % 6))
            paths.append(path)

            path.move(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: index % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 3) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 4) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 5) % 6))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index % 6], radius: newRadius, cornerIndex: (index + 0) % 6))
            paths.append(path)
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
            path.move(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (5 + index % 6)))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (0 + index % 6)))
            path.addLine(to: centerPoints[index % 6])
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (4 + index % 6)))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (5 + index % 6)))
            path.closeSubpath()
            paths.append(path)

            path.move(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (1 + index % 6)))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (2 + index % 6)))
            path.addLine(to: centerPoints[index % 6])
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (0 + index % 6)))
            path.addLine(to: eastWestHexagonCorner(center: centerPoints[index], radius: newRadius, cornerIndex: (1 + index % 6)))
            path.closeSubpath()
            paths.append(path)
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
    SixSidedRosetteView(hexRadius: 200)
}
