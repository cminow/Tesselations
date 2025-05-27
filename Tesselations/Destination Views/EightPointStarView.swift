//
//  EightPointStarView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/27/25.
//

import SwiftUI

struct EightPointStarView: View {
    var blockWidth: CGFloat
    let strokeStyle: StrokeStyle = .init(lineWidth: 2.0, lineCap: .round, lineJoin: .round)

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / blockWidth
                let columns: CGFloat = size.width / blockWidth
                
                for row in 0...Int(rows + 4) {
                    for column in 0...Int(columns + 4) {
                        let center: CGPoint =  CGPoint(x: Double(row) * blockWidth * 1.5,
                                                       y: Double(column) * blockWidth * 1.5)
                        let mainStarPath = starPath(center: center, blockWidth: blockWidth)

                        context.fill(mainStarPath, with: .color(.red))

                        let smallStarCenter: CGPoint = CGPoint(x: center.x + blockWidth * 0.75, y: center.y + blockWidth * 0.75)

                        let smallStarPath = starPath(center: smallStarCenter, blockWidth: blockWidth / 2.0)
                        
                        context.fill(smallStarPath, with: .color(.blue))

                        let petalFillerPaths: [Path] = petalFillerPaths(center: smallStarCenter, blockWidth: blockWidth)

                        for path in petalFillerPaths {
                            context.fill(path, with: .color(.green))
                        }
                        
                        context.stroke(mainStarPath, with: .color(.gray), style: strokeStyle)
                        context.stroke(smallStarPath, with: .color(.gray), style: strokeStyle)

                        for path in petalFillerPaths {
                            context.stroke(path, with: .color(.gray), style: strokeStyle)
                        }
                        
                    }
                }
            }
        }
    }

    private func petalFillerPaths(center: CGPoint, blockWidth: CGFloat) -> [Path] {
        var paths: [Path] = []
        var halfBlockWidth: CGFloat = blockWidth / 2.0
        var quarterBlockWidth: CGFloat = blockWidth / 4.0
        
        var path1 = Path()
        path1.move(to: CGPoint(x: center.x, y: center.y - quarterBlockWidth * 3.0))
        path1.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y - halfBlockWidth))
        path1.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y - quarterBlockWidth))
        path1.addLine(to: CGPoint(x: center.x + quarterBlockWidth / 2.0, y: center.y - quarterBlockWidth))
        path1.addLine(to: CGPoint(x: center.x, y: center.y - quarterBlockWidth * 1.5))
        path1.addLine(to: CGPoint(x: center.x - quarterBlockWidth / 2.0, y: center.y - quarterBlockWidth))
        path1.addLine(to: CGPoint(x: center.x - quarterBlockWidth, y: center.y - quarterBlockWidth))
        path1.addLine(to: CGPoint(x: center.x - quarterBlockWidth, y: center.y - halfBlockWidth))
        path1.addLine(to: CGPoint(x: center.x, y: center.y - quarterBlockWidth * 3.0))
        path1.closeSubpath()
        paths.append(path1)

        var path2 = Path()
        path2.move(to: CGPoint(x: center.x + quarterBlockWidth * 3.0, y: center.y))
        path2.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y + quarterBlockWidth))
        path2.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y + quarterBlockWidth))
        path2.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y + quarterBlockWidth / 2.0))
        path2.addLine(to: CGPoint(x: center.x + quarterBlockWidth * 1.5, y: center.y ))
        path2.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y - quarterBlockWidth / 2.0))
        path2.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y - quarterBlockWidth))
        path2.addLine(to: CGPoint(x: center.x + quarterBlockWidth * 2.0, y: center.y - quarterBlockWidth))
        path2.addLine(to: CGPoint(x: center.x + quarterBlockWidth * 3.0, y: center.y))
        path2.closeSubpath()
        paths.append(path2)

        quarterBlockWidth = -quarterBlockWidth
        halfBlockWidth = -halfBlockWidth
        
        var path3 = Path()
        path3.move(to: CGPoint(x: center.x + quarterBlockWidth * 3.0, y: center.y))
        path3.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y + quarterBlockWidth))
        path3.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y + quarterBlockWidth))
        path3.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y + quarterBlockWidth / 2.0))
        path3.addLine(to: CGPoint(x: center.x + quarterBlockWidth * 1.5, y: center.y ))
        path3.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y - quarterBlockWidth / 2.0))
        path3.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y - quarterBlockWidth))
        path3.addLine(to: CGPoint(x: center.x + quarterBlockWidth * 2.0, y: center.y - quarterBlockWidth))
        path3.addLine(to: CGPoint(x: center.x + quarterBlockWidth * 3.0, y: center.y))
        path3.closeSubpath()
        paths.append(path3)

        var path4 = Path()
        path4.move(to: CGPoint(x: center.x, y: center.y - quarterBlockWidth * 3.0))
        path4.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y - halfBlockWidth))
        path4.addLine(to: CGPoint(x: center.x + quarterBlockWidth, y: center.y - quarterBlockWidth))
        path4.addLine(to: CGPoint(x: center.x + quarterBlockWidth / 2.0, y: center.y - quarterBlockWidth))
        path4.addLine(to: CGPoint(x: center.x, y: center.y - quarterBlockWidth * 1.5))
        path4.addLine(to: CGPoint(x: center.x - quarterBlockWidth / 2.0, y: center.y - quarterBlockWidth))
        path4.addLine(to: CGPoint(x: center.x - quarterBlockWidth, y: center.y - quarterBlockWidth))
        path4.addLine(to: CGPoint(x: center.x - quarterBlockWidth, y: center.y - halfBlockWidth))
        path4.addLine(to: CGPoint(x: center.x, y: center.y - quarterBlockWidth * 3.0))
        path4.closeSubpath()
        paths.append(path4)
        
        return paths
    }
    
    private func starPath(center: CGPoint, blockWidth: CGFloat) -> Path {
        var path: Path = Path()
        let halfBlock: CGFloat = blockWidth / 2.0
        let quarterBlock: CGFloat = blockWidth / 4.0
        
        path.move(to: CGPoint(x: center.x - halfBlock, y: center.y - halfBlock))
        path.addLine(to: CGPoint(x: center.x - quarterBlock, y: center.y - halfBlock))
        path.addLine(to: CGPoint(x: center.x, y: center.y - halfBlock - quarterBlock))
        path.addLine(to: CGPoint(x: center.x + quarterBlock, y: center.y - halfBlock))
        path.addLine(to: CGPoint(x: center.x + halfBlock, y: center.y - halfBlock))
        path.addLine(to: CGPoint(x: center.x + halfBlock, y: center.y - quarterBlock))
        path.addLine(to: CGPoint(x: center.x + halfBlock + quarterBlock, y: center.y))
        path.addLine(to: CGPoint(x: center.x + halfBlock, y: center.y + quarterBlock))
        path.addLine(to: CGPoint(x: center.x + halfBlock, y: center.y + halfBlock))
        path.addLine(to: CGPoint(x: center.x + quarterBlock, y: center.y + halfBlock))
        path.addLine(to: CGPoint(x: center.x, y: center.y + halfBlock + quarterBlock))
        path.addLine(to: CGPoint(x: center.x -  quarterBlock, y: center.y + halfBlock))
        path.addLine(to: CGPoint(x: center.x -  quarterBlock, y: center.y + halfBlock))
        path.addLine(to: CGPoint(x: center.x -  halfBlock, y: center.y + halfBlock))
        path.addLine(to: CGPoint(x: center.x -  halfBlock, y: center.y + quarterBlock))
        path.addLine(to: CGPoint(x: center.x -  halfBlock -  quarterBlock, y: center.y))
        path.addLine(to: CGPoint(x: center.x -  halfBlock, y: center.y - quarterBlock))
        path.addLine(to: CGPoint(x: center.x -  halfBlock, y: center.y - halfBlock))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    EightPointStarView(blockWidth: 128)
}
