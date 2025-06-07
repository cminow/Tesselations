//
//  OctagonsAndStarsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/7/25.
//

import SwiftUI

struct OctagonsAndStarsView: View {
    var radius: CGFloat
    var body: some View {
        VStack {
            Canvas(rendersAsynchronously: true) { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                let rect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: rect), with: .color(.cyan))
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        let center: CGPoint = CGPoint(x: Double(column) * radius * 2.0, y: Double(row) * radius * 2.0)
//                        let layoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * sqrt(2.0), inscribedPolygonInitialAngle: .degrees(45.0))
//                        context.stroke(layoutCircle.inscribedSquare.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        let layoutCircle3: LayoutCircle = LayoutCircle(center: center, radius: radius * 0.875)
                        
                        context.fill(layoutCircle3.inscribedOctagon.path, with: .color(.white))
                        
//                        let octagon: Octagon = Octagon(center: CGPoint(x: center.x + radius, y: center.y + radius), radius: radius * sqrt(2.0) / 2.5, initialAngle: .degrees(22.5))
//                        context.stroke(octagon.stellatedPath, with: .color(.cyan), lineWidth: 1.0)
                        
                        for index in 0...7 {
                            let radialLine: Path = radialLine(center: center,
                                                              startRadius: 0.0,
                                                              length: radius * tan(22.5) * sqrt(2.0) + radius * 0.3,
                                                              angle: .degrees(22.50 + 45.0 * Double(index)))
                            context.stroke(radialLine, with: .color(.black), style: .init(lineWidth: 3.0))
                        }

                        for index in 0...3 {
                            let triangle: Path = triangle(center: center,
                                                          radius: radius * tan(22.5) * sqrt(2.0) + radius * 0.3,
                                                          cornerIndex: index,
                                                          angle: .degrees(-22.5 + 90 * Double(index)))
                            context.fill(triangle, with: .color(.white))
                        }
                        
                        let layoutCircle2: LayoutCircle = LayoutCircle(center: center, radius: radius * 0.33333, inscribedPolygonInitialAngle: .degrees(22.5))
                        
                        context.fill(layoutCircle2.inscribedOctagon.stellatedPath, with: .color(.yellow))
                        context.stroke(layoutCircle2.inscribedOctagon.stellatedPath, with: .color(.black), style: .init(lineWidth: 2.0))
                        
                        context.stroke(layoutCircle3.inscribedOctagon.path, with: .color(.black), lineWidth: 2.0)
                        
                    }
                }
            }
        }
    }

    private func triangle(center: CGPoint, radius: CGFloat, cornerIndex: Int, angle: Angle) -> Path {
        let additiveAngle: Angle = Angle(degrees: 45.0)
        var path: Path = Path()
        path.move(to: center)
        
        let point2: CGPoint = CGPoint(
            x: center.x + radius * cos(CGFloat(angle.radians)),
            y: center.y + radius * sin(angle.radians)
        )
        
        path.addLine(to: point2)
        
        let point3: CGPoint = CGPoint(
            x: center.x + radius * cos(CGFloat(angle.radians + additiveAngle.radians)),
            y: center.y + radius * sin(angle.radians + additiveAngle.radians)
        )
        path.addLine(to: point3)
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }
    
    private func radialLine(center: CGPoint, startRadius: CGFloat, length: CGFloat, angle: Angle) -> Path {
        var path: Path = Path()
        let startPoint: CGPoint = CGPoint(
            x: center.x + startRadius * cos(CGFloat(angle.radians)),
            y: center.y + startRadius * sin(angle.radians)
        )
        let endPoint: CGPoint = CGPoint(
            x: center.x + (startRadius + length) * cos(CGFloat(angle.radians)),
            y: center.y + (startRadius + length) * sin(angle.radians)
        )

        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        return path
    }
}

#Preview {
    OctagonsAndStarsView(radius: 64)
}
