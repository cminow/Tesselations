//
//  WavyTrianglesAlternateView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/13/25.
//

import SwiftUI

struct WavyTrianglesAlternateView: View {
    var radius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                let backgroundRect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: backgroundRect), with: .color(.red))

                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0
                        var degreeOffset: CGFloat = 15.0
                        var radiusFactor: CGFloat = 0.515
                        
                        
                        if column % 2 != 0 {
                            columnOffset = radius * sqrt(3) / 2.0
                        }

                        if row % 2 != 0 {
                            degreeOffset = -45.0
                            radiusFactor = 0.565
                        } else {
                            degreeOffset = 15.0
                        }

                        let center = CGPoint(
                            x: Double(column) * radius * 1.5,
                            y: Double(row) * radius * sqrt(3) + columnOffset
                        )
                        
                        let mainLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius)
//                        context.stroke(mainLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        context.fill(mainLayoutCircle.inscribedHexagon.path,
                                     with: .radialGradient(Gradient(colors: [.red, .blue, .yellow]), center: center, startRadius: radius, endRadius: 0.0))
                        
                        let innerLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * radiusFactor, inscribedPolygonInitialAngle: .degrees(degreeOffset))
//                        context.stroke(innerLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        var flipFactor: CGFloat = 1.0
                        for index in 0...5 {
                            let path = trianglePath(center: innerLayoutCircle.inscribedHexagon.points[index], radius: radius * 0.2 * flipFactor)
                            context.fill(path, with: .color(.black))
                            flipFactor = -flipFactor
                        }
                        
                    }
                }
            }
        }
    }

    private func trianglePath(center: CGPoint, radius: CGFloat) -> Path {
        var path: Path = Path()
        let centralLayoutCircle: LayoutCircle = .init(center: center, radius: radius, inscribedPathDirection: .northSouth)
        let bottomLeftCenterPoint: CGPoint = CGPoint(
            x: center.x - radius * .sqrt3 / 2.0,
            y: center.y + radius * 1.5
        )

        path.addArc(center: bottomLeftCenterPoint,
                    radius: radius,
                    startAngle: .degrees(210.0),
                    endAngle: .degrees(330.0),
                    clockwise: false)
        path.addArc(center: centralLayoutCircle.inscribedHexagon.points[0],
                    radius: radius,
                    startAngle: .degrees(150),
                    endAngle: .degrees(30),
                    clockwise: true)
        
        let rightCenterPoint:CGPoint = CGPoint(
            x: center.x + radius * .sqrt3,
            y: center.y
        )

        path.addArc(center: rightCenterPoint,
                    radius: radius,
                    startAngle: .degrees(90),
                    endAngle: .degrees(210),
                    clockwise: false)
        path.addArc(center: centralLayoutCircle.inscribedHexagon.points[4],
                    radius: radius,
                    startAngle: .degrees(30),
                    endAngle: .degrees(270),
                    clockwise: true)

        let topLeftPoint: CGPoint = CGPoint(
            x: center.x - radius * .sqrt3 / 2.0,
            y: center.y - radius * 1.5
        )

        path.addArc(center: topLeftPoint,
                    radius: radius,
                    startAngle: .degrees(330.0),
                    endAngle: .degrees(90.0),
                    clockwise: false)
        path.addArc(center: centralLayoutCircle.inscribedHexagon.points[2],
                    radius: radius,
                    startAngle: .degrees(270),
                    endAngle: .degrees(150),
                    clockwise: true)
        path.closeSubpath()
        return path
    }
}

#Preview {
    WavyTrianglesAlternateView(radius: 64)
}
