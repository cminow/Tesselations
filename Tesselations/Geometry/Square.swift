//
//  Square.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/6/25.
//

import SwiftUI

struct Square {
    var center: CGPoint
    var radius: CGFloat
    var points: [CGPoint]
    var initialAngle: Angle

    var path: Path {
        var path: Path = Path()
        path.move(to: points[0])
        for index in 1...3 {
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
        for index in 0...3 {
            points.append(cornerPoint(center: center, radius: radius, cornerIndex: index))
        }
    }

    private func cornerPoint(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angle: CGFloat = (CGFloat(90).radians * CGFloat(cornerIndex)) + initialAngle.radians
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }
}
