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
                        context.fill(smallStarPath, with: .color(red: 0.0, green: 0.2, blue: 1.0))

                        let smallStarPath2 = starPath(center: smallStarCenter, blockWidth: blockWidth / 2.50)
                        context.fill(smallStarPath2, with: .color(red: 0.0, green: 0.5, blue: 1.0))

                        let smallStarPath3 = starPath(center: smallStarCenter, blockWidth: blockWidth / 4.0)
                        context.fill(smallStarPath3, with: .color(red: 0.0, green: 0.75, blue: 1.0))

                        let mediumStarPath = starPath(center: center, blockWidth: blockWidth * 0.85)
                        context.fill(mediumStarPath, with: .color(red: 0.65, green: 0.250, blue: 0.0))
                        
                        let centerStarPath = starPath(center: center, blockWidth: blockWidth * 0.6)
                        context.fill(centerStarPath, with: .radialGradient(Gradient(colors: [.red, .yellow]), center: center, startRadius: blockWidth * 0.5, endRadius: 0.0))
                        
                        let petalFillerPaths: [Path] = petalFillerPaths(center: smallStarCenter, blockWidth: blockWidth)
                        for path in petalFillerPaths {
                            context.fill(path, with: .color(red: 0.0, green: 0.7, blue: 0.0))
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
        
        for _ in 0...1 {
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
        }
        
        return paths
    }
    
    private func starPath(center: CGPoint, blockWidth: CGFloat) -> Path {
        var path: Path = Path()
        var halfBlock: CGFloat = blockWidth / 2.0
        var quarterBlock: CGFloat = blockWidth / 4.0

        path.move(to: CGPoint(x: center.x - halfBlock, y: center.y - halfBlock))

        for _ in 0...1 {
            path.addLine(to: CGPoint(x: center.x - quarterBlock, y: center.y - halfBlock))
            path.addLine(to: CGPoint(x: center.x, y: center.y - halfBlock - quarterBlock))
            path.addLine(to: CGPoint(x: center.x + quarterBlock, y: center.y - halfBlock))
            path.addLine(to: CGPoint(x: center.x + halfBlock, y: center.y - halfBlock))
            path.addLine(to: CGPoint(x: center.x + halfBlock, y: center.y - quarterBlock))
            path.addLine(to: CGPoint(x: center.x + halfBlock + quarterBlock, y: center.y))
            path.addLine(to: CGPoint(x: center.x + halfBlock, y: center.y + quarterBlock))
            path.addLine(to: CGPoint(x: center.x + halfBlock, y: center.y + halfBlock))
            // Draws the second half:
            halfBlock = -halfBlock
            quarterBlock = -quarterBlock
        }
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    EightPointStarView(blockWidth: 128)
}
