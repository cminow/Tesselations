//
//  Octagon.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/6/25.
//

import SwiftUI

struct Octagon {
    var center: CGPoint
    var radius: CGFloat
    var points: [CGPoint]
    var initialAngle: Angle

    var path: Path {
        var path = Path()
        path.move(to: points[0])
        for index in 1...7 {
            path.addLine(to: points[index])
        }
        path.addLine(to: points[0])
        path.closeSubpath()
        return path
    }

    var stellatedPath: Path {
        var path: Path = Path()
        let innerOctagon: Octagon = Octagon(center: center, radius: radius * 0.765, initialAngle: initialAngle + .degrees(22.5))
        path.move(to: points[0])
        path.addLine(to: innerOctagon.points[0])
        for index in 1...7 {
            path.addLine(to: points[index])
            path.addLine(to: innerOctagon.points[index])
        }
        path.addLine(to: points[0])
        path.closeSubpath()
        return path
    }

    var secondStellatedPath: Path {
        var path: Path = Path()
        let innerOctagon: Octagon = Octagon(center: center, radius: radius * 0.57465125, initialAngle: initialAngle + .degrees(22.5))
        path.move(to: points[0])
        path.addLine(to: innerOctagon.points[0])
//        let slope1: CGFloat = (points[0].y - innerOctagon.points[0].y) / (points[0].x - innerOctagon.points[0].x)
//        print("Slope 1: \(slope1)")
//        let slope2: CGFloat = (points[2].y - innerOctagon.points[3].y) / (points[2].x - innerOctagon.points[3].x)
//        print("Slope 2: \(1.0 - slope2)")
//        print("Slope Difference: \(slope1 - (1.0 - slope2))")
        for index in 1...7 {
            path.addLine(to: points[index])
            path.addLine(to: innerOctagon.points[index])
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
        for index in 0...7 {
            points.append(octagonPoint(center: center, radius: radius, cornerIndex: index))
        }
    }

    private func octagonPoint(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angle: CGFloat = (CGFloat(45).radians * CGFloat(cornerIndex)) + initialAngle.radians
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }
}
