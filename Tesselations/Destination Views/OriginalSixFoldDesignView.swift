//
//  OriginalSixFoldDesignView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/21/25.
//

import SwiftUI

struct OriginalSixFoldDesignView: View {
    var radius: CGFloat
    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0

                        if column % 2 != 0 {
                            columnOffset = radius * sqrt(3) / 2.0
                        }
                        let center = CGPoint(x: Double(column) * radius * 1.5, y: Double(row) * radius * .sqrt3 + columnOffset)
                        
                        let layoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius)
                        context.stroke(layoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))

                        for (index, point) in layoutCircle.inscribedHexagon.points.enumerated() {
                            let hexagon = cornerHexagon(center: point, radius: radius / 3.0 / .sqrt3, cornerIndex: index)
                            context.stroke(hexagon, with: .color(.black), style: .init(lineWidth: 1.0, lineCap: .round, lineJoin: .round))
                        }

                        let outerLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius * 0.81)
//                        context.stroke(outerLayoutCircle.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        context.stroke(outerLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        let innerLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / .sqrt3 / 2.0, inscribedPathDirection: .northSouth)
                        context.stroke(innerLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        let middleLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / 2.0)
                        context.stroke(middleLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        context.stroke(middleLayoutCircle.inscribedHexagon.inscribedSixPointStarPath, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        let thirdLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / .sqrt3, inscribedPathDirection: .northSouth)
                        context.stroke(thirdLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        for index in 0...5 {
                            let petalPath: Path = outerPetalPath(innerLayoutCircle: thirdLayoutCircle, outerLayoutCircle: outerLayoutCircle, radius: radius, cornerIndex: index)
//                            context.fill(petalPath, with: .color(.blue))
                            context.stroke(petalPath, with: .color(.black), style: .init(lineWidth: 1.0))
                        }
                        
                        let kiteLayoutCircle: LayoutCircle = LayoutCircle(center: center, radius: radius / 4.0)
                        context.stroke(kiteLayoutCircle.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        
                        for index in 0...5 {
                            let kitePath: Path = kiteLayoutPath(layoutCircle1: kiteLayoutCircle, layoutCircle2: innerLayoutCircle, cornerIndex: index)
                            context.stroke(kitePath, with: .color(.black), style: .init(lineWidth: 1.0))
                        }
                    }
                }
            }
        }
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
