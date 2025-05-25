//
//  InterlockingYsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/25/25.
//

//  Essentially, this is just 4 hexagons connected in a different way.

import SwiftUI

struct InterlockingYsView: View {
    var hexRadius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows = (size.height * 1.5) / hexRadius
                let columns = size.width / hexRadius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var columnOffset: CGFloat = 0.0

                        if column % 2 == 1 {
                            columnOffset = -hexRadius * 1.5
                        }
                        
                        var center = CGPoint(x: 1.50 * Double(column) * hexRadius * sqrt(3.0), y: 2.0 * Double(row) * hexRadius * 1.5 + columnOffset)
                        
                        let paths: [Path] = paths(center: center, radius: hexRadius)
                        context.fill(paths[0], with: .color(.red))
                        context.fill(paths[1], with: .color(.blue))
                        context.fill(paths[2], with: .color(.yellow))
                    }
                }
            }
        }
    }

    private func paths(center: CGPoint, radius: CGFloat) -> [Path] {
        var path1: Path = Path()
        var path2: Path = Path()
        var path3: Path = Path()

        let leftCenter: CGPoint = hexagonCorner(center: center, radius: radius, cornerIndex: 4)
        let rightCenter: CGPoint = hexagonCorner(center: center, radius: radius, cornerIndex: 0)
        let bottomCenter: CGPoint = hexagonCorner(center: center, radius: radius, cornerIndex: 2)

        path1.move(to: center)
        path1.addLine(to: hexagonCorner(center: leftCenter, radius: radius, cornerIndex: 4))
        path1.addLine(to: hexagonCorner(center: leftCenter, radius: radius, cornerIndex: 5))
        path1.addLine(to: hexagonCorner(center: center, radius: radius, cornerIndex: 5))
        path1.addLine(to: hexagonCorner(center: rightCenter, radius: radius, cornerIndex: 5))
        path1.addLine(to: hexagonCorner(center: rightCenter, radius: radius, cornerIndex: 0))
        path1.addLine(to: center)
        path1.closeSubpath()
        
        path2.move(to: center)
        path2.addLine(to: hexagonCorner(center: rightCenter, radius: radius, cornerIndex: 0))
        path2.addLine(to: hexagonCorner(center: rightCenter, radius: radius, cornerIndex: 1))
        path2.addLine(to: hexagonCorner(center: center, radius: radius, cornerIndex: 1))
        path2.addLine(to: hexagonCorner(center: bottomCenter, radius: radius, cornerIndex: 0))
        path2.addLine(to: hexagonCorner(center: bottomCenter, radius: radius, cornerIndex: 1))
        path2.addLine(to: hexagonCorner(center: bottomCenter, radius: radius, cornerIndex: 2))
        path2.addLine(to: center)
        path2.closeSubpath()
        
        path3.move(to: center)
        path3.addLine(to: hexagonCorner(center: bottomCenter, radius: radius, cornerIndex: 2))
        path3.addLine(to: hexagonCorner(center: bottomCenter, radius: radius, cornerIndex: 3))
        path3.addLine(to: hexagonCorner(center: center, radius: radius, cornerIndex: 3))
        path3.addLine(to: hexagonCorner(center: leftCenter, radius: radius, cornerIndex: 3))
        path3.addLine(to: hexagonCorner(center: leftCenter, radius: radius, cornerIndex: 4))
        path3.addLine(to: center)
        
        return [path1, path2, path3]
    }
    
    func hexagonCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let angleDegrees: CGFloat = (60.0 * CGFloat(cornerIndex)) - 30.0
        let angleRadians: CGFloat = .pi / 180.0 * angleDegrees
        let corner = CGPoint(
            x: center.x + radius * cos(angleRadians),
            y: center.y + radius * sin(angleRadians)
        )
        return corner
    }
}

#Preview {
    InterlockingYsView(hexRadius: 16.0)
}
