//
//  CGPoint.swift
//  Tessellations
//
//  Created by Charlie Minow on 5/31/25.
//

import Foundation

extension CGPoint {
    static func lineIntersectionPoint(line1Start: CGPoint, line1End: CGPoint, line2Start: CGPoint, line2End: CGPoint) -> CGPoint? {
        let delta1X = line1End.x - line1Start.x
        let delta1Y = line1End.y - line1Start.y
        let delta2X = line2End.x - line2Start.x
        let delta2Y = line2End.y - line2Start.y
        
        let determinient = delta1X * delta2Y - delta2X * delta1Y
        
        if abs(determinient) < 0.0001 {
            // Must be parallel or the same line. I.e., no intersection or all intersection.
            return nil
        }

        let ab = ((line1Start.y - line2Start.y) * delta2X - (line1Start.x - line2Start.x) * delta2Y) / determinient
        
        if ab > 0 && ab < 1 {
            let cd: CGFloat = ((line1Start.y - line2Start.y) * delta1X - (line1Start.x - line1Start.x) * delta1Y) / determinient
            if cd > 0 && cd < 1 {
                let intersectionX = line1Start.x + ab * delta1X
                let intersectionY = line1Start.y + ab * delta1Y
                return CGPoint(x: intersectionX, y: intersectionY)
            }
        }
        
        // No intersection:
        return nil
    }
}
