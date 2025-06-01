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

                        let backgroundPath: Path = northSouthHexPath(radius: radius * 0.99, center: center)
                        context.fill(backgroundPath, with: .color(.red))

                        let mediumStar: Path = sixPointStartPath(center: center, radius: radius * 0.25 * .sqrt3, initialRotation: .degrees(30.0))
                        context.fill(mediumStar, with: .color(.blue))
                        
                        let smallStar: Path = sixPointStartPath(center: center, radius: radius * 0.25, initialRotation: .degrees(0.0))
                        context.fill(smallStar, with: .color(.white))

                        let petalPaths: [Path] = middlePetalPaths(center: center, radius: radius)
                        for (index, path) in petalPaths.enumerated() {
                            context.stroke(path, with: .color(.black), style: .init(lineWidth: 2.0))
                        }
                    }
                }
            }
        }
    }

    private func middlePetalPaths(center: CGPoint, radius: CGFloat) -> [Path] {
        var paths: [Path] = []
        
        return paths
    }
    
    private func sixPointStartPath(center: CGPoint, radius: CGFloat, initialRotation: Angle) -> Path {
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
}

#Preview {
    SixPointedStarView(radius: 128)
}
