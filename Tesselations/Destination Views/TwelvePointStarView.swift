//
//  TwelvePointStarView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/3/25.
//

import SwiftUI

struct TwelvePointStarView: View {
    var radius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = (size.height * 1.5) / radius
                let columns: CGFloat = size.width / radius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0

                        if row % 2 != 0 {
                            rowOffset = radius * .sqrt3 / 2.0
                        }
                        let center = CGPoint(x: Double(column) * radius * sqrt(3.0) + rowOffset, y: Double(row) * radius * 1.5)

                        for layoutFactor: CGFloat in stride(from: 1.0, to: 0.0, by: -0.2) {
                            let layoutPath: Path = northSouthHexPath(radius: radius * layoutFactor, center: center)
                            context.stroke(layoutPath, with: .color(.black), style: .init(lineWidth: 1.0, lineCap: .round, lineJoin: .round))
                        }

                        let centerStar1: Path = sixPointStarPath(center: center, radius: radius * .sqrt3 / 9.0, initialRotation: .degrees(0.0))
                        context.fill(centerStar1, with: .color(.black))
                        let centerStar2: Path = sixPointStarPath(center: center, radius: radius * .sqrt3 / 9.0, initialRotation: .degrees(30.0))
                        context.fill(centerStar2, with: .color(.black))

                        for index in 0...5 {
                            let centerPoint: CGPoint = northSouthHexagonCorner(center: center, radius: radius, cornerIndex: index)
                            let cornerHexPath: Path = northSouthHexPath(radius: radius * .sqrt3 / 9.0, center: centerPoint)
                            context.fill(cornerHexPath, with: .color(.red))
                        }
                        
                        for index in 0...5 {
                            let centerPoint: CGPoint = northSouthHexagonCorner(center: center, radius: radius * 0.6, cornerIndex: index)
                            let cornerHexPath: Path = northSouthHexPath(radius: radius * .sqrt3 / 9.0, center: centerPoint)
                            context.fill(cornerHexPath, with: .color(.blue))
                        }
                    }
                }
            }
        }
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
    TwelvePointStarView(radius: 128.0)
}
