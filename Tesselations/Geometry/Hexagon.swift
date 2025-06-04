//
//  Hexagon.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/4/25.
//

import SwiftUI

struct Hexagon {
    var center: CGPoint
    var radius: CGFloat
    var points: [CGPoint]
    var direction: HexDirection
    
    var path: Path {
        var path: Path = Path()
        path.move(to: points[0])
        for index in 1...5 {
            path.addLine(to: points[index])
        }
        path.closeSubpath()
        return path
    }
    
    var inscribedSixPointStarPath: Path {
        var insideHexDirection: HexDirection
        let radiusFactor: CGFloat = .sqrt3 / 3.0
        var insideHexPointOffset: Int

        switch direction {
        case .northSouth:
            insideHexDirection = .eastWest
            insideHexPointOffset = 1
        case .eastWest:
            insideHexDirection = .northSouth
            insideHexPointOffset = 0
        }
        
        let insideHexagon: Hexagon = Hexagon(center: center, radius: radius * radiusFactor, direction: insideHexDirection)
        
        var path: Path = Path()
        path.move(to: points[0])
        path.addLine(to: insideHexagon.points[0 + insideHexPointOffset])
        for index in 1...5 {
            path.addLine(to: points[index])
            path.addLine(to: insideHexagon.points[(index + insideHexPointOffset) % 6])
        }
        path.closeSubpath()
        return path
    }
    
    init(center: CGPoint, radius: CGFloat, direction: HexDirection = .eastWest) {
        self.center = center
        self.radius = radius
        self.direction = direction
        points = []
        for index in 0...5 {
            points.append(hexagonCorner(center: center, radius: radius, direction: direction, cornerIndex: index))
        }
    }

    private func hexagonCorner(center: CGPoint, radius: CGFloat, direction: HexDirection, cornerIndex: Int) -> CGPoint {
        var initialAngleOffset: CGFloat = 0.0
        if direction == .northSouth {
            initialAngleOffset = CGFloat(30.0).radians
        }
        
        let angle: CGFloat = (CGFloat(60).radians * CGFloat(cornerIndex)) + initialAngleOffset
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }
}

enum HexDirection {
    case northSouth
    case eastWest
}
