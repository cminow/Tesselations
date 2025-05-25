//
//  Shape.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/25/25.
//

import SwiftUI

struct RegularPolygon: Shape {
    let radius: CGFloat
    let cornerCount: Int

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)

        let path = Path()

        guard let polyPath: Path = polygonPath(center: center, radius: radius, cornerCount: cornerCount) else { return path }
        
        return polyPath
    }
    
    private func polygonPath(center: CGPoint, radius: CGFloat, cornerCount: Int) -> Path? {
        guard cornerCount > 2 else { return nil }

        var path = Path()
        path.move(to: polygonCorner(center: center, radius: radius, cornerCount: cornerCount, cornerIndex: 0))
        for cornerIndex in 1...cornerCount {
            path.addLine(to: polygonCorner(center: center, radius: radius, cornerCount: cornerCount, cornerIndex: cornerIndex))
        }
        path.closeSubpath()
        return path
    }
    
    private func polygonCorner(center: CGPoint, radius: CGFloat, cornerCount: Int, cornerIndex: Int) -> CGPoint {
        let perStepAngle: CGFloat = (2.0 * .pi) / Double(cornerCount)
        let angleRadians: CGFloat = perStepAngle * Double(cornerIndex) - (.pi * 0.5)
        let corner = CGPoint(
            x: center.x + radius * cos(angleRadians),
            y: center.y + radius * sin(angleRadians)
        )
        return corner
    }
}
