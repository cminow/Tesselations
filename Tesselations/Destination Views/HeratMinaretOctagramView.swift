//
//  HeratMinaretOctagramView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/18/25.
//  Inspired by: https://www.youtube.com/watch?v=gmYW-NuEkYk
//

import SwiftUI

struct HeratMinaretOctagramView: View {
    var blockWidth: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = 1.1 * size.height / blockWidth
                let columns: CGFloat = size.width / blockWidth
                let lineWidth: CGFloat = blockWidth / 32.0
                let backgroundRect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: backgroundRect), with: .color(.black))
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        let center: CGPoint = CGPoint(x: Double(column) * blockWidth, y: Double(row) * blockWidth)
                        
//                        let layoutGrid: Path = layoutGrid(center: center, blockWidth: blockWidth)
//                        context.stroke(layoutGrid, with: .color(.cyan), style: .init(lineWidth: 1.0))

                        let layoutCircle: LayoutCircle = LayoutCircle(center: center, radius: blockWidth / .sqrt3 / 2.0)
//                        context.stroke(layoutCircle.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        context.fill(layoutCircle.inscribedOctagon.stellatedPath, with: .color(.red))
                        context.stroke(layoutCircle.inscribedOctagon.stellatedPath, with: .color(.white), style: .init(lineWidth: lineWidth,lineCap: .round, lineJoin: .round))
                        
                        let verticalStretchedStar: Path = verticalStretchedStar(center: center, blockWidth: blockWidth)
                        context.fill(verticalStretchedStar, with: .color(.red))
                        context.stroke(verticalStretchedStar, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))

                        let horizontalStretchedStar: Path = horizontalStretchedStar(center: center, blockWidht: blockWidth)
                        context.fill(horizontalStretchedStar, with: .color(.red))
                        context.stroke(horizontalStretchedStar, with: .color(.white), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    }
                }
            }
        }
    }

    private func horizontalStretchedStar(center: CGPoint, blockWidht: CGFloat) ->  Path {
        let gridPointWidth: CGFloat = blockWidth / 7.0
        let bottomLeftCorner: CGPoint = CGPoint(x: center.x - blockWidth / 2.0, y: center.y + blockWidth / 2.0)
        var path: Path = Path()
        path.move(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth, y: bottomLeftCorner.y))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 2.0, y: bottomLeftCorner.y - gridPointWidth))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 3.0, y: bottomLeftCorner.y - gridPointWidth))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 3.50, y: bottomLeftCorner.y - gridPointWidth * 1.5))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 4.0, y: bottomLeftCorner.y - gridPointWidth))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 5.0, y: bottomLeftCorner.y - gridPointWidth))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 6.0, y: bottomLeftCorner.y))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 5.0, y: bottomLeftCorner.y + gridPointWidth))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 4.0, y: bottomLeftCorner.y + gridPointWidth))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 3.50, y: bottomLeftCorner.y + gridPointWidth * 1.5))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 3.0, y: bottomLeftCorner.y + gridPointWidth))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth * 2.0, y: bottomLeftCorner.y + gridPointWidth))
        path.addLine(to: CGPoint(x: bottomLeftCorner.x + gridPointWidth, y: bottomLeftCorner.y))
        path.closeSubpath()
        return path
    }
    
    private func verticalStretchedStar(center: CGPoint, blockWidth: CGFloat) -> Path {
        let gridPointWidth: CGFloat = blockWidth / 7.0
        let upperRightCorner: CGPoint = CGPoint(x: center.x + blockWidth / 2.0, y: center.y - blockWidth / 2.0)
        var path: Path = Path()
        path.move(to: CGPoint(x: upperRightCorner.x, y: upperRightCorner.y + gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x + gridPointWidth, y: upperRightCorner.y + 2.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x + gridPointWidth, y: upperRightCorner.y + 3.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x + 1.5 * gridPointWidth, y: upperRightCorner.y + 3.5 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x + gridPointWidth, y: upperRightCorner.y + 4.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x + gridPointWidth, y: upperRightCorner.y + 5.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x, y: upperRightCorner.y + 6.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x - gridPointWidth, y: upperRightCorner.y + 5.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x - gridPointWidth, y: upperRightCorner.y + 4.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x - 1.5 * gridPointWidth, y: upperRightCorner.y + 3.5 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x - gridPointWidth, y: upperRightCorner.y + 3.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x - gridPointWidth, y: upperRightCorner.y + 2.0 * gridPointWidth))
        path.addLine(to: CGPoint(x: upperRightCorner.x, y: upperRightCorner.y + gridPointWidth))
        path.closeSubpath()
        return path
    }
    
    private func layoutGrid(center: CGPoint, blockWidth: CGFloat) -> Path {
        var path = Path()
        let points = gridPoints(center: center, blockWidth: blockWidth)
        
        path.move(to: points[0][0])
        path.addLine(to: points[0][7])
        path.addLine(to: points[7][7])
        path.addLine(to: points[7][0])
        path.addLine(to: points[0][0])
        for column in 1...6 {
            path.move(to: points[0][column])
            path.addLine(to: points[7][column])
        }
        
        for row in 1...6 {
            path.move(to: points[row][0])
            path.addLine(to: points[row][7])
        }
        
        return path
    }

    private func gridPoints(center: CGPoint, blockWidth: CGFloat) -> [[CGPoint]] {
        var points: [[CGPoint]] = Array(repeating: Array(repeating: .zero, count: 8), count: 8)
        let upperLeftCorner: CGPoint = CGPoint(x: center.x - blockWidth / 2.0, y: center.y - blockWidth / 2.0)
        
        for row in 0...7 {
            for column in 0...7 {
                let point: CGPoint = CGPoint(
                    x: upperLeftCorner.x + Double(column) * blockWidth / 7.0,
                    y: upperLeftCorner.y + Double(row) * blockWidth / 7.0
                )
                points[row][column] = point
            }
        }
        return points
    }
}

#Preview {
    HeratMinaretOctagramView(blockWidth: 128)
}
