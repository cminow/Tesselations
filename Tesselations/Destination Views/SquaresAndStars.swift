//
//  SquaresAndStars.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/6/25.
//

import SwiftUI

struct SquaresAndStars: View {
    var radius: CGFloat
    var body: some View {
        VStack {
            Canvas(rendersAsynchronously: true) { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                
                let backgroundPath: Path = Rectangle().path(in: context.clipBoundingRect)
                context.fill(backgroundPath, with: .color(.red))
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0

                        if row % 2 != 0 {
                            rowOffset = radius * sqrt(3.0) / 2.0
                        }
                        let center = CGPoint(x: Double(column) * radius * sqrt(3.0) + rowOffset, y: Double(row) * radius * 1.5)

                        let backgroundCircle: LayoutCircle = LayoutCircle(center: center, radius: radius, inscribedPathDirection: .northSouth)
                        context.fill(backgroundCircle.inscribedHexagon.path,
                                     with: .radialGradient(Gradient(colors: [.red, .yellow, .red]), center: center, startRadius: radius, endRadius: 0.0))
                        
                        var layoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * .sqrt3 / 2.78)
                        layoutCircle.inscribedPathDirection = .northSouth
                        
                        for (index, point) in layoutCircle.inscribedHexagon.points.enumerated() {
                            let insetCircle: LayoutCircle = LayoutCircle(center: point, radius: radius * .sqrt3 / 4.74, inscribedPolygonInitialAngle: .degrees(Double(index + 2) * 60))
                            let brightness: Double = .random(in: 0.25...0.50)
                            context.fill(insetCircle.inscribedSquare.path, with: .color(.init(hue: 0.5, saturation: 1.0, brightness: brightness)))
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    SquaresAndStars(radius: 64)
}
