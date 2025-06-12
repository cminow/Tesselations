//
//  BlackAndWhiteBlocksView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/11/25.
//

import SwiftUI

struct BlackAndWhiteBlocksView: View {
    var blockWidth: CGFloat
    
    var body: some View {
        VStack {
            Canvas(rendersAsynchronously: true) { context, size in
                let rows: CGFloat = size.height / blockWidth
                let columns: CGFloat = size.width / blockWidth
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {

                        var center: CGPoint = CGPoint(
                            x: Double(column) * blockWidth * 2.0,
                            y: Double(row) * blockWidth * 2.0
                        )

                        let shoulderIndent: CGFloat = blockWidth / 6.0

                        for _ in 0...1 {
                            let paths = blockPaths(center: center, blockWidth: blockWidth, shoulderIndent: shoulderIndent)
                            
                            for (index, path) in paths.enumerated() {
                                if index % 2 == 0 {
                                    let whiteness: Double = .random(in: 0.10...0.150)
                                    context.fill(path, with: .color(.init(white: whiteness)))
                                } else {
                                    let brightness: Double = .random(in: 0.75...1.0)
                                    context.fill(path, with: .color(.init(hue: 0.55, saturation: 0.50, brightness: brightness)))
                                }
                            }
                            
                            center.x += blockWidth
                            center.y += blockWidth
                        }
                    }
                }
            }
        }
    }

    private func blockPaths(center: CGPoint, blockWidth: CGFloat, shoulderIndent: CGFloat) -> [Path] {
        var paths: [Path] = []
        
        let halfBlockWidth: CGFloat = blockWidth / 2.0
        
        var mirror: CGFloat = 1.0
        
        for _ in 0...1 {
            var path: Path = Path()
            path.move(to: center)
            path.addLine(to: CGPoint(x: center.x + mirror * (halfBlockWidth - shoulderIndent), y: center.y - halfBlockWidth))
            path.addLine(to: CGPoint(x: center.x + mirror * (halfBlockWidth), y: center.y - halfBlockWidth))
            path.addLine(to: CGPoint(x: center.x + mirror * (halfBlockWidth), y: center.y - halfBlockWidth + shoulderIndent))
            path.addLine(to: CGPoint(x: center.x + mirror * (blockWidth), y: center.y))
            path.addLine(to: CGPoint(x: center.x + mirror * (halfBlockWidth), y: center.y + halfBlockWidth -  shoulderIndent))
            path.addLine(to: CGPoint(x: center.x + mirror * (halfBlockWidth), y: center.y + halfBlockWidth))
            path.addLine(to: CGPoint(x: center.x + mirror * (halfBlockWidth), y: center.y + halfBlockWidth))
            path.addLine(to: CGPoint(x: center.x + mirror * (halfBlockWidth - shoulderIndent), y: center.y + halfBlockWidth))
            path.addLine(to: center)
            path.closeSubpath()
            paths.append(path)

            var path2: Path = Path()
            path2.move(to: center)
            path2.addLine(to: CGPoint(x: center.x - halfBlockWidth + shoulderIndent, y: center.y - mirror * halfBlockWidth))
            path2.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y - mirror * halfBlockWidth))
            path2.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y - mirror * (halfBlockWidth + shoulderIndent)))
            path2.addLine(to: CGPoint(x: center.x, y: center.y - mirror * blockWidth))
            path2.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y - mirror * (halfBlockWidth + shoulderIndent)))
            path2.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y - mirror * halfBlockWidth))
            path2.addLine(to: CGPoint(x: center.x + halfBlockWidth -  shoulderIndent, y: center.y - mirror * halfBlockWidth))
            path2.addLine(to: center)
            path2.closeSubpath()
            paths.append(path2)

            // Flips the layout to its mirror image on the second pass:
            mirror = -mirror
        }

        return paths
    }
}

#Preview {
    BlackAndWhiteBlocksView(blockWidth: 64)
}
