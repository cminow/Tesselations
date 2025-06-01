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

                        let backgroundPath: Path = northSouthHexPath(radius: radius * 0.95, center: center)
                        
                        
                        context.fill(backgroundPath, with: .color(.red))
                    }
                }
            }
        }
    }

    func northSouthHexPath(radius: CGFloat, center: CGPoint) -> Path {
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
    SixPointedStarView(radius: 16.0)
}
