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
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                
                var remainder: Int = 0
                for row in 0...Int(rows) {
                    remainder = row % 2
                    for column in 0...Int(columns) {
                        
                        var backColor: GraphicsContext.Shading = .color(.white)
                        var middleColor: GraphicsContext.Shading = .color(.blue)
                        var frontColor: GraphicsContext.Shading = .color(.yellow)

                        if column % 2 == remainder {
                            backColor =  .color(.blue)
                            middleColor = .color(.yellow)
                            frontColor = .color(.blue)
                        }

                        let center: CGPoint = CGPoint(x: Double(column) * radius * 2.0, y: Double(row) * radius * 2.0)
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
}

#Preview {
    AlternatingOctagonalStarsView(radius: 64)
}
