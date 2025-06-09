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
                let rows: CGFloat = (size.height * 1.5) / radius
                let columns: CGFloat = size.width / radius
                context.translateBy(x: size.width / 2.0, y: size.height / 2.0)
                
                let center: CGPoint = .zero
                let triangle: Path = trianglePath(center: center, radius: radius)
                context.fill(triangle, with: .color(.blue))

                let center2: CGPoint = CGPoint(x: radius * .sqrt3, y: -radius * 1.0)
                let triangle2: Path = trianglePath(center: center2, radius: -radius)
                context.fill(triangle2, with: .color(.red))

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
        let layoutCircle1: LayoutCircle = .init(center: bottomLeftCenterPoint, radius: radius, inscribedPathDirection: .northSouth)
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
        let layoutCircle2: LayoutCircle = .init(center: rightCenterPoint, radius: radius, inscribedPathDirection: .northSouth)
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
        let leftLayoutCircle: LayoutCircle = .init(center: topLeftPoint, radius: radius, inscribedPathDirection: .northSouth)

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
    WavyTrianglesView(radius: 32)
}
