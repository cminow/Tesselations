//
//  OriginalSixFoldDesignView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/21/25.
//

import SwiftUI

struct OriginalSixFoldDesignView: View {
    var radius: CGFloat
    let cornerColors: [GraphicsContext.Shading] = [
        .color(.init(hue: 0.50, saturation: 1.0, brightness: 0.350)),
        .color(.init(hue: 0.50, saturation: 1.0, brightness: 0.450)),
        .color(.init(hue: 0.50, saturation: 1.0, brightness: 0.5))
    ]

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius

                let lineWidth: CGFloat = radius * 0.01

                let rect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: rect), with: .color(.init(hue: 0.0, saturation: 1.5, brightness: 0.65)))
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0

                        if column % 2 != 0 {
                            columnOffset = radius * sqrt(3) / 2.0
                        }
                        let center = CGPoint(x: Double(column) * radius * 1.5, y: Double(row) * radius * .sqrt3 + columnOffset)
                        
                        let layoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius)
//                        context.stroke(layoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))

                        let secondaryLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * 0.86667, inscribedPathDirection: .northSouth)
//                        context.stroke(secondaryLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))

                        for (index, point) in layoutCircle.inscribedHexagon.points.enumerated() {
                            let hexagon = cornerHexagon(center: point, radius: radius / 3.0 / .sqrt3, cornerIndex: index)
                            context.fill(hexagon, with: cornerColors[index % 3])
                            context.stroke(hexagon, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        }

                        let outerLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * 0.81)
//                        context.stroke(outerLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
//                        context.stroke(outerLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        let innerLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / .sqrt3 / 2.0, inscribedPathDirection: .northSouth)
                        context.fill(innerLayoutCircle.inscribedHexagon.path, with: .color(.init(hue: 0.125, saturation: 1.0, brightness: 1.0)))
//                        context.stroke(innerLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        let middleLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / 2.0)
//                        context.stroke(middleLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
//                        context.stroke(middleLayoutCircle.inscribedHexagon.inscribedSixPointStarPath, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        let thirdLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / .sqrt3, inscribedPathDirection: .northSouth)
//                        context.stroke(thirdLayoutCircle.path, with: .color(.cyan), style: .init(lineWidth: 40.0))
                        
                        for index in 0...5 {
                            var brightness: Double = 0.350
                            if index % 2 == 0 {
                                brightness = 0.5
                            }
                            let petalPath: Path = outerPetalPath(innerLayoutCircle: thirdLayoutCircle, outerLayoutCircle: outerLayoutCircle, radius: radius, cornerIndex: index)
//                            context.fill(petalPath, with: .color(.init(hue: 0.025, saturation: 0.750, brightness: brightness)))
//                            context.stroke(petalPath, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        }
                        
                        let kiteLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / 4.0)
//                        context.stroke(kiteLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        for index in 0...5 {
                            var brightness: Double = 0.90
                            if index % 2 == 0 {
                                brightness = 0.8
                            }
                            let kitePath: Path = kiteLayoutPath(layoutCircle1: kiteLayoutCircle, layoutCircle2: innerLayoutCircle, cornerIndex: index)
                            let fillColor: GraphicsContext.Shading = .color(.init(hue: 1.0, saturation: 1.0, brightness: brightness))
//                            context.fill(kitePath, with: fillColor)
//                            context.stroke(kitePath, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        }

                        for index in 0...5 {
                            let kitePath: Path = outerKitePath(innerLayoutCircle: middleLayoutCircle, outerLayoutCircle: outerLayoutCircle, radius: radius, cornerIndex: index)
                            context.fill(kitePath, with: .color(.init(red: 0.350, green: 0.0, blue: 0.0)))
                            context.stroke(kitePath, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        }

                        for index in 0...5 {
                            var brightness: Double = 0.50
                            if index % 2 == 0 {
                                brightness = 0.65
                            }
                            let diamondPath = diamondPath(innerLayoutCircle: innerLayoutCircle,
                                                          middleLayoutCircle: middleLayoutCircle,
                                                          outerLayoutCircle: thirdLayoutCircle,
                                                          cornerIndex: index)
                            context.fill(diamondPath, with: .color(.init(hue: 0.0, saturation: 1.0, brightness: brightness)))
                            context.stroke(diamondPath, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        }

                        for index in 0...5 {
                            var brightness: Double = 0.5
                            if index % 2 == 0 {
                                brightness = 0.7
                            }
                            let starPoint: Path = startPointPath(innerLayoutCircle: innerLayoutCircle, outerLayoutCircle: middleLayoutCircle, cornerIndex: index)
                            context.fill(starPoint, with: .color(.init(hue: 0.075, saturation: 1.0, brightness: brightness)))
                            context.stroke(starPoint, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        }

                        for index in 0...5 {
                            var brightness: Double = 0.75
                            if index % 2 == 0 {
                                brightness = 0.5
                            }
                            let outerDiamond: Path = edgeFiller(innerLayoutCircle: thirdLayoutCircle,
                                                                middleLayoutCircle: outerLayoutCircle,
                                                                outerLayoutCircle: secondaryLayoutCircle,
                                                                radius: radius,
                                                                cornerIndex: index)
                            context.fill(outerDiamond, with: .color(.init(hue: 0.1, saturation: 1.0, brightness: brightness)))
                            context.stroke(outerDiamond, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        }
                    }
                }
            }
        }
    }

    private func edgeFiller(innerLayoutCircle: LayoutCircle,
                            middleLayoutCircle: LayoutCircle,
                            outerLayoutCircle: LayoutCircle,
                            radius: CGFloat,
                            cornerIndex: Int) -> Path {
        let cornerHexagon: Hexagon = Hexagon(center: middleLayoutCircle.inscribedHexagon.points[cornerIndex], radius: radius / 3.0 / .sqrt3)
        let cornerHexagon2: Hexagon = Hexagon(center: middleLayoutCircle.inscribedHexagon.points[(cornerIndex + 1) % 6], radius: radius / 3.0 / .sqrt3)
        var path: Path = Path()
        path.move(to: innerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.addLine(to: cornerHexagon.points[(cornerIndex + 2) % 6])
        path.addLine(to: outerLayoutCircle.inscribedHexagon.points[(cornerIndex + 0) % 6])
        path.addLine(to: cornerHexagon2.points[(cornerIndex + 5) % 6])
        path.addLine(to: innerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.closeSubpath()
        return path
    }
    
    private func startPointPath(innerLayoutCircle: LayoutCircle,
                                outerLayoutCircle: LayoutCircle,
                                cornerIndex: Int) -> Path {
        var path: Path = Path()
        path.move(to: outerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.addLine(to: innerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.addLine(to: innerLayoutCircle.inscribedHexagon.points[(cornerIndex + 5) % 6])
        path.addLine(to: outerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.closeSubpath()
        return path
    }
    
    private func diamondPath(innerLayoutCircle: LayoutCircle, middleLayoutCircle: LayoutCircle, outerLayoutCircle: LayoutCircle, cornerIndex: Int) -> Path {
        var path: Path = Path()
        path.move(to: outerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.addLine(to: middleLayoutCircle.inscribedHexagon.points[(cornerIndex + 1) % 6])
        path.addLine(to: innerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.addLine(to: middleLayoutCircle.inscribedHexagon.points[(cornerIndex + 6) % 6])
        path.addLine(to: outerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.closeSubpath()
        return path
    }
    
    private func outerKitePath(innerLayoutCircle: LayoutCircle, outerLayoutCircle: LayoutCircle, radius: CGFloat, cornerIndex: Int) -> Path {
        var path: Path = Path()
        let cornerHexagon: Hexagon = Hexagon(center: outerLayoutCircle.inscribedHexagon.points[cornerIndex], radius: radius / 3.0 / .sqrt3)
        path.move(to: cornerHexagon.center)
        path.addLine(to: cornerHexagon.points[(cornerIndex + 2) % 6])
        path.addLine(to: innerLayoutCircle.inscribedHexagon.points[cornerIndex % 6])
        path.addLine(to: cornerHexagon.points[(cornerIndex + 4) % 6])
        path.addLine(to: cornerHexagon.center)
        path.closeSubpath()
        return path
    }
    
    private func kiteLayoutPath(layoutCircle1: LayoutCircle, layoutCircle2: LayoutCircle, cornerIndex: Int) -> Path {
        var path: Path = Path()
        path.move(to: layoutCircle1.center)
        path.addLine(to: layoutCircle1.inscribedHexagon.points[cornerIndex])
        path.addLine(to: layoutCircle2.inscribedHexagon.points[cornerIndex])
        path.addLine(to: layoutCircle1.inscribedHexagon.points[(cornerIndex + 1) % 6])
        path.addLine(to: layoutCircle1.center)
        path.closeSubpath()
        return path
    }
    
    private func outerPetalPath(innerLayoutCircle: LayoutCircle, outerLayoutCircle: LayoutCircle, radius: CGFloat , cornerIndex: Int) -> Path {
        var path: Path = Path()
        let cornerHexagon: Hexagon = Hexagon(center: outerLayoutCircle.inscribedHexagon.points[cornerIndex], radius: radius / 3.0 / .sqrt3)
        path.move(to: cornerHexagon.center)
        path.addLine(to: cornerHexagon.points[(cornerIndex + 1) % 6])
        path.addLine(to: cornerHexagon.points[(cornerIndex + 2) % 6])
        path.addLine(to: innerLayoutCircle.inscribedHexagon.points[cornerIndex])
        path.addLine(to: innerLayoutCircle.inscribedHexagon.points[(cornerIndex + 5) % 6])
        path.addLine(to: cornerHexagon.points[(cornerIndex + 4) % 6])
        path.addLine(to: cornerHexagon.points[(cornerIndex + 5) % 6])
        path.addLine(to: cornerHexagon.center)
        path.closeSubpath()
        return path
    }
    
    private func cornerHexagon(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> Path {
        let fullHexagon: Hexagon = Hexagon(center: center, radius: radius)
        var path: Path = Path()
        path.move(to: center)
        path.addLine(to: fullHexagon.points[(cornerIndex + 1) % 6])
        path.addLine(to: fullHexagon.points[(cornerIndex + 2) % 6])
        path.addLine(to: fullHexagon.points[(cornerIndex + 3) % 6])
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }
}

#Preview {
    OriginalSixFoldDesignView(radius: 128)
}
