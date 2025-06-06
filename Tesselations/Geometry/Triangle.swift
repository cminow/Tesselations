//
//  Triangle.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/6/25.
//

import SwiftUI

struct Triangle {
    var center: CGPoint
    var radius: CGFloat
    var points: [CGPoint]
    var initialAngle: Angle

    var path: Path {
        var path = Path()
        path.move(to: points[0])
        for index in 1...2 {
            path.addLine(to: points[index])
        }
        path.addLine(to: points[0])
        path.closeSubpath()
        return path
    }
    
    init(center: CGPoint, radius: CGFloat, initialAngle: Angle) {
        self.center = center
        self.radius = radius
        self.initialAngle = initialAngle
        points = []
        for index in 0...2 {
            points.append(triangleCorner(center: center, radius: radius, cornerIndex: index, initialAngle: initialAngle))
        }
    }
    
    private func triangleCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int, initialAngle: Angle) -> CGPoint {
        let angle: CGFloat = (CGFloat(120).radians * CGFloat(cornerIndex)) + initialAngle.radians
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }
}
