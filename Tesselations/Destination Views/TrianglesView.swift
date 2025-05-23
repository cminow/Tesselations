//
//  TrianglesView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/22/25.
//

import SwiftUI

struct TrianglesView: View {
    var hexRadius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows = size.height / hexRadius
                let columns = (size.width * 1.86667) / hexRadius
                let insetFactor: CGFloat = 0.95
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0
                        if row % 2 == 1 {
                            rowOffset -= hexRadius * 0.8666667
                        }
                        // offset is sqrt(3) for the horizonal, but the constant is close enough.
                        let center = CGPoint(x: Double(column) * 1.732051 * hexRadius + rowOffset, y: Double(row) * hexRadius * 1.5)
                        let mainPath: Path = trianglePath(hexCenter: center,
                                                          radius: hexRadius * insetFactor)
                        let brightness: Double = .random(in: 0.50...0.75)

                        context.fill(mainPath, with: .color(.init(hue: 0.0,
                                                                  saturation: 0.0,
                                                                  brightness: brightness,
                                                                  opacity: 1.0)))

                        let secondaryBrightness: Double = .random(in: 0.50...0.75)
                        let secondaryPath: Path = trianglePath(hexCenter: CGPoint(x: center.x + (hexRadius * 0.86667),
                                                                                  y: center.y + (hexRadius * 0.5)),
                                                               radius: -hexRadius * insetFactor)
                        context.fill(secondaryPath, with: .color(.init(hue: 0.0,
                                                                       saturation: 0.0,
                                                                       brightness: secondaryBrightness,
                                                                       opacity: 1.0)))
                    }
                }
            }
        }
    }

    func trianglePath(hexCenter: CGPoint, radius: CGFloat) -> Path {
        var path = Path()
        let topPoint: CGPoint = CGPoint(x: hexCenter.x, y: hexCenter.y + radius)
        let rightPoint: CGPoint = CGPoint(x: hexCenter.x + (radius * 0.86667),
                                          y: hexCenter.y - (radius * 0.5))
        let leftPoint: CGPoint = CGPoint(x: hexCenter.x - (radius * 0.86667),
                                         y: hexCenter.y - (radius * 0.5))
        path.move(to: topPoint)
        path.addLine(to: rightPoint)
        path.addLine(to: leftPoint)
        path.addLine(to: topPoint)
        path.closeSubpath()
        return path
    }
}

#Preview {
    TrianglesView(hexRadius: 32.0)
}
