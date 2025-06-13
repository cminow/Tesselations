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
                
                
                for row in 0...Int(rows) {
                    var flipFactor: CGFloat = -1.0
                    for column in 0...Int(columns) {
                        
                        let center: CGPoint = CGPoint(
                            x: Double(column) * radius * 1.50,
                            y: Double(row) * radius * 1.5
                        )
                        let path: Path = trianglePath(center: center, radius: radius / .sqrt3 / 1.50 * flipFactor)

                        context.fill(path, with: .color(.black))
                        
                        flipFactor = -flipFactor
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
    WavyTrianglesAlternateView(radius: 32.0)
}
