//
//  SixPointedStarView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/1/25.
//

import SwiftUI

struct SixPointedStarView: View {
    var radius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0

                        if row % 2 != 0 {
                            rowOffset = radius * .sqrt3 / 2.0
                        }
                        let center = CGPoint(x: Double(column) * radius * .sqrt3 + rowOffset, y: Double(row) * radius * 1.5)

                        let outerPetalPath: Path = outerPetalpath(center: center, radius: radius * 0.75, initialAngle: .degrees(15.0))
                        context.fill(outerPetalPath, with: .color(.white))

                        let petalPaths: [Path] = middlePetalPaths(center: center, radius: radius * (.sqrt3 / 2.0), initialAngle: .degrees(30))
                        for (index, path) in petalPaths.enumerated() {
                            var fillColor: GraphicsContext.Shading = .color(red: 0.350, green: 0.350, blue: 0.750)
                            if index % 2 == 1 {
                                fillColor = .color(red: 0.5, green: 0.5, blue: 0.750)
                            }
                            context.fill(path, with: fillColor)
                        }

                        // Corner hexagons (only need 3):
                        for index in -1...1 {
                            let centerPoint: CGPoint = northSouthHexagonCorner(center: center, radius: radius, cornerIndex: index)
                            let cornerHexagon = northSouthHexPath(radius: radius * 0.25, center: centerPoint)
                            var fillColor: GraphicsContext.Shading = .color(red: 0.0, green: 0.650, blue: 0.750)
                            if abs(index % 2) == 1 {
                                fillColor = .color(red: 0.0, green: 0.5, blue: 0.750)
                            }
                            context.fill(cornerHexagon, with: fillColor)
                            
                            fillColor = .color(.init(hue: 0.0, saturation: 0.50, brightness: 1.0))
                            if abs(index % 2) == 1 {
                                fillColor = .color(.init(hue: 0.0, saturation: 0.350, brightness: 0.950))
                            }

                            let tinyStar = sixPointStarPath(center: centerPoint, radius: radius * (.sqrt3 / 8), initialRotation: .degrees(0.0))
                            context.fill(tinyStar, with: fillColor)
                        }

                        // Fill the little diamonds (also only need 3:
                        for index in 0...2 {
                            let centerPoint: CGPoint = eastWestHexagonCorner(center: center, radius: radius, cornerIndex: index)
                            let cornerHexagon = eastWestHexPath(radius: radius / (.sqrt3 * 2.0), center: centerPoint)
                            var fillColor: GraphicsContext.Shading = .color(red: 1.0, green: 0.650, blue: 0.750)
                            if abs(index % 2) == 1 {
                                fillColor = .color(red: 1.0, green: 0.5, blue: 0.750)
                            }
                            context.fill(cornerHexagon, with: fillColor)
                        }
                        
                        let smallStar: Path = sixPointStarPath(center: center, radius: radius * (.sqrt3 / 4.0), initialRotation: .degrees(0.0))
                        context.fill(smallStar, with: .color(.white))

                        let smallestStar: Path = sixPointStarPath(center: center, radius: radius * 0.25, initialRotation: .degrees(30.0))
                        context.fill(smallestStar, with: .color(.init(hue: 0.66667, saturation: 0.25, brightness: 1.0)))
                        
                    }
                }
            }
        }
    }

    private func outerPetalpath(center: CGPoint, radius: CGFloat, initialAngle: Angle) -> Path {
        var path: Path = Path()
        let incrementAngle: Angle = Angle(degrees: 15)
        
        let firstPoint: CGPoint = CGPoint(
            x: center.x + radius * cos(0.0 + initialAngle.radians) * 1.2,
            y: center.y + radius * sin(0.0 + initialAngle.radians) * 1.2
        )
        
        path.move(to: firstPoint)
        
        for index in 1...23 {

            let pointOffset: CGFloat
            if index % 2 == 1 {
                pointOffset = .sqrt3 / 1.75
            } else {
                pointOffset = 1.20
            }

            let newRadius: CGFloat = pointOffset * radius
            
            let point: CGPoint = CGPoint(
                x: center.x + newRadius * cos(initialAngle.radians + Double(index) * incrementAngle.radians),
                y: center.y + newRadius * sin(initialAngle.radians + Double(index) * incrementAngle.radians)
            )
            path.addLine(to: point)
        }
        path.closeSubpath()
        
        return path
    }

    private func middlePetalPaths(center: CGPoint, radius: CGFloat, initialAngle: Angle) -> [Path] {
        var paths: [Path] = []

        let incrementAngle: CGFloat = Angle(degrees: 60.0).radians
        
        for index in 0...5 {
            var path: Path = Path()
            path.move(to: center)

            let x1: CGFloat = center.x + radius * cos(Double(index) * incrementAngle + initialAngle.radians - (.pi / 6.0)) / 2.0
            let y1: CGFloat =  center.y + radius * sin(Double(index) * incrementAngle + initialAngle.radians - (.pi / 6.0)) / 2.0
            path.addLine(to: CGPoint(x: x1, y:y1))

            let x2: CGFloat = center.x + radius * cos(Double(index) * incrementAngle + initialAngle.radians) * (.sqrt3 / 2.0)
            let y2: CGFloat =  center.y + radius * sin(Double(index) * incrementAngle + initialAngle.radians) * (.sqrt3 / 2.0)
            path.addLine(to: CGPoint(x: x2, y: y2))

            let x3: CGFloat = center.x + radius * cos(Double(index) * incrementAngle + initialAngle.radians + (.pi / 6.0)) / 2.0
            let y3: CGFloat =  center.y + radius * sin(Double(index) * incrementAngle + initialAngle.radians + (.pi / 6.0)) / 2.0
            path.addLine(to: CGPoint(x: x3, y:y3))
            path.addLine(to: center)
            path.closeSubpath()
            paths.append(path)
        }
        
        return paths
    }
    
    private func sixPointStarPath(center: CGPoint, radius: CGFloat, initialRotation: Angle) -> Path {
        var path = Path()
        
        let angleIncrement: Angle = .degrees(30.0)
        let firstPoint: CGPoint = CGPoint(
            x: center.x + radius * cos(0.0 + initialRotation.radians),
            y: center.y + radius * sin(0.0 + initialRotation.radians)
        )
        
        path.move(to: firstPoint)
        for index in 1...11 {

            let pointOffset: CGFloat
            if index % 2 == 1 {
                pointOffset = .sqrt3 / 3.0
            } else {
                pointOffset = 1.0
            }

            let newRadius: CGFloat = pointOffset * radius
            
            let point: CGPoint = CGPoint(
                x: center.x + newRadius * cos(0.0 + initialRotation.radians + Double(index) * angleIncrement.radians),
                y: center.y + newRadius * sin(0.0 + initialRotation.radians + Double(index) * angleIncrement.radians)
            )
            path.addLine(to: point)
        }
        path.closeSubpath()
        return path
    }

    private func northSouthHexPath(radius: CGFloat, center: CGPoint) -> Path {
        var path = Path()
        path.move(to: northSouthHexagonCorner(center: center, radius: radius, cornerIndex: 0))
        for index in 1...5 {
            path.addLine(to: northSouthHexagonCorner(center: center, radius: radius, cornerIndex: index))
        }
        path.closeSubpath()
        return path
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

    private func eastWestHexPath(radius: CGFloat, center: CGPoint) -> Path {
        var path = Path()
        path.move(to: eastWestHexagonCorner(center: center, radius: radius, cornerIndex: 0))
        for index in 1...5 {
            path.addLine(to: eastWestHexagonCorner(center: center, radius: radius, cornerIndex: index))
        }
        path.closeSubpath()
        return path
    }
    
    func eastWestHexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angle: CGFloat = (CGFloat(60).radians * CGFloat(cornerIndex))
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }
}

#Preview {
    SixPointedStarView(radius: 64)
}
