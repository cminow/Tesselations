//
//  HexWeaveView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/15/25.
//

import SwiftUI

struct HexWeaveView: View {
    var radius: CGFloat
    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                let backgroundRect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: backgroundRect), with: .color(.purple))
                
                let outlineWidth: CGFloat = radius * 0.05
                
                for row in -1...Int(rows) {
                    for column in -1...Int(columns) {
                        var rowOffset: CGFloat = 0.0

                        if row % 2 != 0 {
                            rowOffset = radius * sqrt(3.0) / 2.0
                        }
                        let center = CGPoint(x: Double(column) * radius * sqrt(3.0) + rowOffset, y: Double(row) * radius * 1.5)
                        
                        let layoutCircle1: LayoutCircle = LayoutCircle(center: center, radius: radius, inscribedPathDirection: .northSouth)
//                        context.stroke(layoutCircle1.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
//                        context.stroke(layoutCircle1.inscribedHexagon.inscribedSixPointStarPath, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        let innerCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * 0.5775)
//                        context.stroke(innerCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        var path1 = Path()
                        let point1: CGPoint = CGPoint(
                            x: center.x,
                            y: center.y - radius
                        )
                        path1.move(to: point1)
                        let point2: CGPoint = CGPoint(
                            x: center.x + radius * .sqrt3 / 1.50,
                            y: center.y - radius
                        )
                        path1.addLine(to: point2)
                        let point3: CGPoint = CGPoint(
                            x: center.x + radius * .sqrt3 / 2.0,
                            y: center.y - radius / 2.0
                        )
                        path1.addLine(to: point3)
                        let point4: CGPoint = CGPoint(
                            x: center.x - radius / (.sqrt3 * 2.0),
                            y: center.y - radius / 2.0
                        )
                        path1.addLine(to: point4)
                        path1.addLine(to: point1)
                        path1.closeSubpath()
                        context.fill(path1,
                                     with: .linearGradient(
                                        Gradient(colors: [.init(red: 0.75, green: 0.0, blue: 0.0), .red, .red, .init(red: 0.75, green: 0.0, blue: 0.0)]), startPoint: point1, endPoint: point3))

                        var path2: Path = Path()
                        
                        let point5: CGPoint = innerCircle.inscribedHexagon.points[5]
                        path2.move(to: point5)
                        let point6: CGPoint = CGPoint(
                            x: center.x + radius * .sqrt3 / 2.0,
                            y: center.y -  radius / 2.0
                        )
                        path2.addLine(to: point6)
                        let point7: CGPoint = CGPoint(
                            x: center.x + radius * .sqrt3 / 1.20,
                            y: center.y + radius / 2.0
                        )
                        path2.addLine(to: point7)
                        path2.addLine(to: layoutCircle1.inscribedHexagon.points[0])
                        path2.addLine(to: point5)
                        path2.closeSubpath()
                        context.fill(path2,
                                     with: .linearGradient(Gradient(colors: [.init(red: 0.0, green: 0.0, blue: 0.75), .blue, .blue, .init(red: 0.0, green: 0.0, blue: 0.75)]),
                                                           startPoint: point6,
                                                           endPoint: layoutCircle1.inscribedHexagon.points[0]))

                        var path3: Path = Path()
                        path3.move(to: innerCircle.inscribedHexagon.points[0])
                        path3.addLine(to: layoutCircle1.inscribedHexagon.points[0])
                        let point8: CGPoint = CGPoint(
                            x: innerCircle.inscribedHexagon.points[1].x,
                            y: center.y + 2.0 * radius * .sqrt3 / 2.30
                        )
                        path3.addLine(to: point8)
                        path3.addLine(to: layoutCircle1.inscribedHexagon.points[1])
                        path3.addLine(to: innerCircle.inscribedHexagon.points[0])
                        context.fill(path3, with: .linearGradient(Gradient(colors: [.init(red: 0.75, green: 0.75, blue: 0.0), .yellow, .yellow, .init(red: 0.75, green: 0.75, blue: 0.0)]), startPoint: innerCircle.inscribedHexagon.points[0], endPoint: innerCircle.inscribedHexagon.points[2]))
                        
                        context.stroke(path1, with: .color(.white), style: .init(lineWidth: outlineWidth, lineCap: .round, lineJoin: .round))
                        context.stroke(path2, with: .color(.white), style: .init(lineWidth: outlineWidth, lineCap: .round, lineJoin: .round))
                        context.stroke(path3, with: .color(.white), style: .init(lineWidth: outlineWidth, lineCap: .round, lineJoin: .round))
                        
                    }
                }
            }
        }
    }
}

#Preview {
    HexWeaveView(radius: 64)
}
