//
//  AlternatingOctagonalStarsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/7/25.
//

import SwiftUI

struct AlternatingOctagonalStarsView: View {
    var radius: CGFloat
    var body: some View {
        VStack {
            Canvas(rendersAsynchronously: true) { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                let rect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: rect), with: .color(.white))
                
                var remainder: Int = 0
                for row in 0...Int(rows) {
                    remainder = row % 2
                    for column in 0...Int(columns) {
                        let center: CGPoint = CGPoint(x: Double(column) * radius * 2.0, y: Double(row) * radius * 2.0)
                        
                        let mainLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * sqrt(2), inscribedPolygonInitialAngle: .degrees(45))
//                        context.stroke(mainLayoutCircle.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
//                        context.stroke(mainLayoutCircle.inscribedSquare.path, with: .color(.cyan), style: .init(lineWidth: 1.0))

                        var backColor: GraphicsContext.Shading = .color(.white)
                        var middleColor: GraphicsContext.Shading = .color(.blue)
                        var frontColor: GraphicsContext.Shading = .color(.yellow)

                        if column % 2 == remainder {
                            backColor =  .color(.blue)
                            middleColor = .color(.yellow)
                            frontColor = .color(.blue)
                            
                            for (index, point) in mainLayoutCircle.inscribedSquare.points.enumerated() {
                                let flatDiamondPath: Path = flatDiamondPath(center: point, radius: radius * 0.4, angleOffset: .degrees(0.0 * Double(index)), corner: index)
                                context.fill(flatDiamondPath, with: .color(.blue))
                            }
                            
                        } else {
                            let backOctagon: Octagon =  Octagon(center: center, radius: radius * 1.1, initialAngle: .degrees(22.5))
                            context.fill(backOctagon.path, with: .color(.blue))
                        }

                        
                        let backStar: Octagon = Octagon(center: center, radius: radius, initialAngle: .degrees(0.0))
                        context.fill(backStar.stellatedPath, with: backColor)
                        
                        let middleLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * 0.75, inscribedPolygonInitialAngle: .degrees(22.50))
                        context.fill(middleLayoutCircle.inscribedOctagon.secondStellatedPath, with: middleColor)
                        let frontLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * 0.45)
                        context.fill(frontLayoutCircle.inscribedOctagon.stellatedPath, with: frontColor)
                    }
                }
            }
        }
    }

    private func flatDiamondPath(center: CGPoint, radius: CGFloat, angleOffset: Angle, corner: Int) -> Path {
        var rotationAngle: Angle
        if corner % 2 == 1 {
            rotationAngle = .degrees(45)
        } else {
            rotationAngle = .degrees(135)
        }
        var path = Path()
        var actualRadius: CGFloat = radius
        path.move(to: cornerPoint(center: center, radius: actualRadius, cornerIndex: 0, initialAngle: rotationAngle + angleOffset))
        for index in 1...3 {
            if index % 2 == 1 {
                actualRadius = radius * (sqrt(2) / 3)
            } else {
                actualRadius = radius
            }
            path.addLine(to: cornerPoint(center: center, radius: actualRadius, cornerIndex: index, initialAngle: rotationAngle + angleOffset))
        }
        path.addLine(to: cornerPoint(center: center, radius: radius, cornerIndex: 0, initialAngle: rotationAngle + angleOffset))
        path.closeSubpath()
        return path
    }

    private func cornerPoint(center: CGPoint, radius: CGFloat, cornerIndex: Int, initialAngle: Angle) -> CGPoint {
        let angle: CGFloat = (CGFloat(90).radians * CGFloat(cornerIndex)) + initialAngle.radians
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }
}

#Preview {
    AlternatingOctagonalStarsView(radius: 32)
}
