//
//  TrianglesView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/22/25.
//

import SwiftUI

struct TrianglesView: View {
    var hexRadius: CGFloat
    let halfSqrt3: CGFloat = sqrt(3.0) / 2.0

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows = size.height / hexRadius
                let columns = (size.width * (1.0 + halfSqrt3 )) / hexRadius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0
                        if row % 2 == 1 {
                            rowOffset -= hexRadius * halfSqrt3
                        }

                        let center = CGPoint(x: Double(column) * (halfSqrt3 * 2.0) * hexRadius + rowOffset, y: Double(row) * hexRadius * 1.5)
                        let mainPath: Path = trianglePath(hexCenter: center,
                                                          radius: hexRadius)
                        let brightness: Double = .random(in: 0.50...0.75)

                        context.fill(mainPath, with: .color(.init(hue: 0.0,
                                                                  saturation: 0.0,
                                                                  brightness: brightness,
                                                                  opacity: 1.0)))

                        context.stroke(mainPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: 0.45)), lineWidth: 1.0)
                        
                        let secondaryBrightness: Double = .random(in: 0.50...0.75)
                        let secondaryPath: Path = trianglePath(hexCenter: CGPoint(x: center.x + (hexRadius * halfSqrt3),
                                                                                  y: center.y + (hexRadius * 0.5)),
                                                               radius: -hexRadius)
                        context.fill(secondaryPath, with: .color(.init(hue: 0.0,
                                                                       saturation: 0.0,
                                                                       brightness: secondaryBrightness,
                                                                       opacity: 1.0)))
                        context.stroke(secondaryPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: 0.45)), lineWidth: 1.0)
                    }
                }
            }
        }
    }

    func trianglePath(hexCenter: CGPoint, radius: CGFloat) -> Path {
        var path = Path()

        let topPoint: CGPoint = CGPoint(x: hexCenter.x, y: hexCenter.y + radius)
        let rightPoint: CGPoint = CGPoint(x: hexCenter.x + (radius * halfSqrt3),
                                          y: hexCenter.y - (radius * 0.5))
        let leftPoint: CGPoint = CGPoint(x: hexCenter.x - (radius * halfSqrt3),
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
