//
//  LayoutCircle.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/6/25.
//

import SwiftUI

struct LayoutCircle {
    var center: CGPoint
    var radius: CGFloat
    var inscribedPathDirection: HexDirection = .eastWest
    var inscribedPolygonInitialAngle: Angle
    
    init(center: CGPoint, radius: CGFloat, inscribedPolygonInitialAngle: Angle = .degrees(0.0)) {
        self.center = center
        self.radius = radius
        self.inscribedPolygonInitialAngle = inscribedPolygonInitialAngle
    }

    var inscribedHexagon: Hexagon {
        return Hexagon(center: center, radius: radius, direction: inscribedPathDirection, initialAngle: inscribedPolygonInitialAngle)
    }

    var inscribedTriangle: Triangle {
        return Triangle(center: center, radius: radius, initialAngle: inscribedPolygonInitialAngle)
    }
    
    var path: Path {
        var path: Path = Path()
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .degrees(360), clockwise:  true)
        return path
    }
    
}
