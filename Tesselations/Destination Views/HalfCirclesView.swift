//
//  HalfCirclesView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/14/25.
//

import SwiftUI

struct HalfCirclesView: View {
    var radius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                let backgroundRect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: backgroundRect), with: .color(.black))
                
                var rowOffset: CGFloat
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        if row % 2 == 1 {
                            rowOffset = -radius
                        } else {
                            rowOffset = 0.0
                        }

                        let center: CGPoint = CGPoint(
                            x: (Double(column) * radius * 2.0) +  rowOffset,
                            y: Double(row) * radius
                        )

//                        Only for debugging the layout: 
//                        let layoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius)
//                        context.stroke(layoutCircle.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        let innerLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / 2.0)
                        
                        var path: Path = Path()
                        path.addArc(center: innerLayoutCircle.inscribedSquare.points[3], radius: radius / 2.0, startAngle: .degrees(0.0), endAngle: .degrees(180.0), clockwise: false)
                        path.addArc(center: innerLayoutCircle.inscribedSquare.points[2], radius: radius / 2.0, startAngle: .degrees(-90), endAngle: .degrees(90.0), clockwise: true)
                        path.addArc(center: innerLayoutCircle.inscribedSquare.points[1], radius: radius / 2.0, startAngle: .degrees(180), endAngle: .degrees(0.0), clockwise: false)
                        path.addArc(center: innerLayoutCircle.inscribedSquare.points[0], radius: radius / 2.0, startAngle: .degrees(90), endAngle: .degrees(-90.0), clockwise: true)
                        context.fill(path, with: .color(.red))
                        
                    }
                }
            }
        }
    }
}

#Preview {
    HalfCirclesView(radius: 32.0)
}
