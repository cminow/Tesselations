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
            Canvas(rendersAsynchronously: true) { context, size in
                let rows: CGFloat = (size.height * 1.5) / radius
                let columns: CGFloat = size.width / radius
                let backgroundRect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: backgroundRect), with: .color(.white))
                
                for row in 0...Int(rows) {
                    var rowOffset: CGFloat = 0.0
                    if row % 2 == 1 {
                        rowOffset = -.sqrt3
                    }
                    for column in -1...Int(columns) {
                        let center: CGPoint = CGPoint(
                            x: Double(column) * radius * .sqrt3 * 2.0 + (radius * rowOffset),
                            y: Double(row) * radius * 3.0
                        )
                        let triangle: Path = trianglePath(center: center, radius: radius)
                        let brightness: Double = .random(in: 0.80...1.0)
                        context.fill(triangle, with: .color(.init(Color(hue: 0.5750, saturation: 1.0, brightness: brightness))))

                        let hexagon: Hexagon = Hexagon(center: center, radius: radius * (.sqrt3 / 2.350))
                        let brightness1: Double = .random(in: 0.950...1.0)
                        context.fill(hexagon.path, with: .color(.init(white: brightness1)))
                        
                        let blackStarCenter: CGPoint = CGPoint(
                            x: center.x + radius * .sqrt3,
                            y: center.y - radius
                        )
                        
                        let triangle2: Path = trianglePath(center: blackStarCenter, radius: -radius)
                        let whiteness: Double = .random(in: 0.90...01.0)
                        context.fill(triangle2, with: .color(.init(white: whiteness)))
                        
                        let hexagon2: Hexagon = Hexagon(center: blackStarCenter, radius: radius * (.sqrt3 / 2.350))
                        let brightness2: Double = .random(in: 0.15...0.35)
                        context.fill(hexagon2.inscribedSixPointStarPath, with: .color(.init(white: brightness2)))
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
//        let layoutCircle1: LayoutCircle = .init(center: bottomLeftCenterPoint, radius: radius, inscribedPathDirection: .northSouth)
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
//        let layoutCircle2: LayoutCircle = .init(center: rightCenterPoint, radius: radius, inscribedPathDirection: .northSouth)
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
//        let leftLayoutCircle: LayoutCircle = .init(center: topLeftPoint, radius: radius, inscribedPathDirection: .northSouth)

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
    WavyTrianglesView(radius: 16)
}
