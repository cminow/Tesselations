//
//  Pentagons.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/2/25.
//

import SwiftUI

struct Pentagons: View {
    var radius: CGFloat
    let horizontalOffset: CGFloat = 0.95
    let verticalOffset: CGFloat = 0.824
    
    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = (size.height / radius)
                let columns: CGFloat = (size.width / radius)

                for row in 0...Int(rows + 5) {
                    for column in 0...Int(columns + 5) {
                        let center: CGPoint = CGPoint(x: Double(column) * radius * horizontalOffset, y: Double(row) * radius * verticalOffset)
                        
                        let innerHex: Path = hexPath(radius: radius / 5.875, center: center)
                        context.fill(innerHex, with: .color(.init(hue: 0.0, saturation: 0.5, brightness: 1.0)))
                        
                        for index in 0...5 {
                            let point: CGPoint = hexagonCorner(center: center, radius: radius / 3.26530612244898, cornerIndex: index)
                            let initialAngle: Angle = .degrees(60.0 * CGFloat(index))
                            let pentagonPath: Path = pentagonPath(center: point, radius: radius / 6.0, initialAngle: initialAngle)
                            context.fill(pentagonPath, with: .color(.red))
                        }
                    }
                }
            }
        }
    }

    private func pentagonPath(center: CGPoint, radius: CGFloat, initialAngle: Angle) -> Path {
        var path = Path()
        path.move(to: pentagonCorner(center: center, radius: radius, cornerIndex: 0, initialAngle: initialAngle))
        for cornerIndex in 1...4 {
            path.addLine(to: pentagonCorner(center: center, radius: radius, cornerIndex: cornerIndex, initialAngle: initialAngle))
        }
        path.closeSubpath()
        return path
    }

    private func pentagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int, initialAngle: Angle) -> CGPoint {
        let perStepAngle: CGFloat = (2.0 * .pi) / 5.0
        let angleRadians: CGFloat = (perStepAngle) * Double(cornerIndex)
        let corner = CGPoint(
            x: center.x + radius * cos(angleRadians + initialAngle.radians),
            y: center.y + radius * sin(angleRadians + initialAngle.radians)
        )
        return corner
    }

    func hexPath(radius: CGFloat, center: CGPoint) -> Path {
        var path = Path()
        path.move(to: hexagonCorner(center: center, radius: radius, cornerIndex: 0))
        for index in 1...5 {
            path.addLine(to: hexagonCorner(center: center, radius: radius, cornerIndex: index))
        }
        path.closeSubpath()
        return path
    }

    private func hexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angle: CGFloat = (CGFloat(60).radians * CGFloat(cornerIndex))
        let corner = CGPoint(
            x: center.x + radius * cos(angle),
            y: center.y + radius * sin(angle)
        )
        return corner
    }
}

#Preview {
    Pentagons(radius: 128)
}
