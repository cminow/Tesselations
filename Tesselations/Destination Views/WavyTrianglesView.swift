//
//  WavyTrianglesView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/9/25.
//

import SwiftUI

struct WavyTrianglesView: View {
    var radius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                context.translateBy(x: size.width / 2.0, y: size.height / 2.0)
                let centralLayoutCircle: LayoutCircle = .init(center: .zero, radius: radius, inscribedPathDirection: .northSouth)
                context.stroke(centralLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))

                var path: Path = Path()
                
                let bottomLeftCenterPoint: CGPoint = CGPoint(
                    x: -radius * .sqrt3 / 2.0,
                    y: radius * 1.5
                )
                let layoutCircle1: LayoutCircle = .init(center: bottomLeftCenterPoint, radius: radius, inscribedPathDirection: .northSouth)
                context.stroke(layoutCircle1.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
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
                    x: radius * .sqrt3,
                    y: 0.0
                )
                let layoutCircle2: LayoutCircle = .init(center: rightCenterPoint, radius: radius, inscribedPathDirection: .northSouth)
                context.stroke(layoutCircle2.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
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
                    x: -radius * .sqrt3 / 2.0,
                    y: -radius * 1.5
                )
                let leftLayoutCircle: LayoutCircle = .init(center: topLeftPoint, radius: radius, inscribedPathDirection: .northSouth)
                context.stroke(leftLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
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
                context.stroke(path, with: .color(.black), style: .init(lineWidth: 2.0))
                context.fill(path, with: .color(.blue))
            }
        }
    }
}

#Preview {
    WavyTrianglesView(radius: 64)
}
