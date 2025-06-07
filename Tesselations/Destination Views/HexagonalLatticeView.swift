//
//  HexagonalLatticeView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/3/25.
//

import SwiftUI

struct HexagonalLatticeView: View {
    var radius: CGFloat
    
    var body: some View {
        VStack {
            Canvas(rendersAsynchronously: true) { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius

                var thickLine: StrokeStyle = .init(lineWidth: 4.0, lineCap: .round, lineJoin: .round)
                var thinLine: StrokeStyle = .init(lineWidth: 2.0, lineCap: .round, lineJoin: .round)
                if radius < 64.0 {
                    thickLine.lineWidth = 2.0
                    thinLine.lineWidth = 1.0
                }

                let backgroundPath: Path = Rectangle().path(in: context.clipBoundingRect)
                context.fill(backgroundPath, with: .color(.black))

                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0

                        if column % 2 != 0 {
                            columnOffset = radius * sqrt(3) / 2.0
                        }

                        let center = CGPoint(x: Double(column) * radius * 1.5, y: Double(row) * radius * sqrt(3) + columnOffset)

                        for index in 0...5 {
                            let centerPoint: CGPoint = eastWestHexagonCorner(center: center, radius: radius, cornerIndex: index)

                            let thinHexagon: Path = eastWestHexPath(center: center, radius: radius * 0.625)
                            context.stroke(thinHexagon, with: .color(.red), style: thinLine)
                            
                            let hexPath: Path = eastWestHexPath(center: centerPoint, radius: radius * 0.5)
                            context.stroke(hexPath, with: .color(.red), style: thickLine)

                            let line: Path = radialLine(center: centerPoint, startRadius: 0.0, length: radius * 0.35, angle: Angle(degrees: Double(index) * 60.0))
                            context.stroke(line, with: .color(.red), style: thinLine)
                            
                            let line2: Path = radialLine(center: centerPoint, startRadius: 0.0, length: radius * .sqrt3 / 4.70, angle: Angle(degrees: Double(index) * 60.0 + 60.0))
                            context.stroke(line2, with: .color(.red), style: thinLine)

                            let insetHex: Path = eastWestHexPath(center: centerPoint, radius: radius / 6)
                            context.stroke(insetHex, with: .color(.red), style: thinLine)
                        }
                        
                        let centerStar: Path = sixPointStarPath(center: center, radius: radius * 0.25, initialRotation: .degrees(30.0))
                        context.stroke(centerStar, with: .color(.red), style: thinLine)

                        for index in 0...5 {
                            let centerPoint: CGPoint = northSouthHexagonCorner(center: center, radius: radius / 2.0 * .sqrt3, cornerIndex: index)
                            let starPath: Path = sixPointStarPath(center: centerPoint, radius: radius * 0.25, initialRotation: .degrees(30.0))
                            context.stroke(starPath, with: .color(.red), style: thinLine)
                        }
                        
                        for index in 0...5 {
                            let angle: Angle = Angle(degrees: Double(index) * 60.0 + 30.0)
                            let path = radialLine(center: center, startRadius: radius * 0.25, length: radius * .sqrt3 / 4.8, angle: angle)
                            context.stroke(path, with: .color(.red), style: thinLine)
                        }

                        for index in 0...5 {
                            let angle: Angle = Angle(degrees: Double(index) * 60.0)
                            let path = radialLine(center: center, startRadius: radius * .sqrt3 / 4.720, length: radius * 0.125, angle: angle)
                            context.stroke(path, with: .color(.red), style: thinLine)
                        }
                        
                        let centerHex: Path = eastWestHexPath(center: center, radius: radius * 0.375)
                        context.stroke(centerHex, with: .color(.red), style: thinLine)
                        
                    }
                }
            }
        }
    }

    private func radialLine(center: CGPoint, startRadius: CGFloat, length: CGFloat, angle: Angle) -> Path {
        var path: Path = Path()
        let startPoint: CGPoint = CGPoint(
            x: center.x + startRadius * cos(CGFloat(angle.radians)),
            y: center.y + startRadius * sin(angle.radians)
        )
        let endPoint: CGPoint = CGPoint(
            x: center.x + (startRadius + length) * cos(CGFloat(angle.radians)),
            y: center.y + (startRadius + length) * sin(angle.radians)
        )

        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        return path
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
    
    private func eastWestHexPath(center: CGPoint, radius: CGFloat) -> Path {
        var path = Path()
        path.move(to: eastWestHexagonCorner(center: center, radius: radius, cornerIndex: 0))
        for index in 1...5 {
            path.addLine(to: eastWestHexagonCorner(center: center, radius: radius, cornerIndex: index))
        }
        path.closeSubpath()
        return path
    }
    
    private func eastWestHexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angle: CGFloat = (CGFloat(60).radians * CGFloat(cornerIndex))
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }

    private func northSouthHexPath(center: CGPoint, radius: CGFloat) -> Path {
        var path = Path()
        path.move(to: northSouthHexagonCorner(center: center, radius: radius, cornerIndex: 0))
        for index in 1...5 {
            path.addLine(to: northSouthHexagonCorner(center: center, radius: radius, cornerIndex: index))
        }
        path.closeSubpath()
        return path
    }
    
    func northSouthHexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
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
    HexagonalLatticeView(radius: 128)
}
