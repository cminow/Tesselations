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
            Canvas { context, size in
                let rows: CGFloat = size.height / blockWidth
                let columns: CGFloat = size.width / blockWidth
//                context.translateBy(x: size.width / 2.0, y: size.height / 2.0)

                
                
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
                                if index < 2 {
                                    context.fill(path, with: .color(.black))
                                } else {
                                    context.fill(path, with: .color(.blue))
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
        
        var path: Path = Path()
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x + halfBlockWidth - shoulderIndent, y: center.y - halfBlockWidth))
        path.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y - halfBlockWidth))
        path.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y - halfBlockWidth + shoulderIndent))
        path.addLine(to: CGPoint(x: center.x + blockWidth, y: center.y))
        path.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y + halfBlockWidth -  shoulderIndent))
        path.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y + halfBlockWidth))
        path.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y + halfBlockWidth))
        path.addLine(to: CGPoint(x: center.x + halfBlockWidth - shoulderIndent, y: center.y + halfBlockWidth))
        path.addLine(to: center)
        path.closeSubpath()
        paths.append(path)
        
        var path2: Path = Path()
        path2.move(to: center)
        path2.addLine(to: CGPoint(x: center.x - halfBlockWidth + shoulderIndent, y: center.y - halfBlockWidth))
        path2.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y - halfBlockWidth))
        path2.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y - halfBlockWidth + shoulderIndent))
        path2.addLine(to: CGPoint(x: center.x - blockWidth, y: center.y))
        path2.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y + halfBlockWidth -  shoulderIndent))
        path2.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y + halfBlockWidth))
        path2.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y + halfBlockWidth))
        path2.addLine(to: CGPoint(x: center.x - halfBlockWidth + shoulderIndent, y: center.y + halfBlockWidth))
        path2.addLine(to: center)
        path2.closeSubpath()
        paths.append(path2)
        
        var path3: Path = Path()
        path3.move(to: center)
        path3.addLine(to: CGPoint(x: center.x - halfBlockWidth + shoulderIndent, y: center.y - halfBlockWidth))
        path3.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y - halfBlockWidth))
        path3.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y - halfBlockWidth - shoulderIndent))
        path3.addLine(to: CGPoint(x: center.x, y: center.y - blockWidth))
        path3.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y - halfBlockWidth - shoulderIndent))
        path3.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y - halfBlockWidth))
        path3.addLine(to: CGPoint(x: center.x + halfBlockWidth -  shoulderIndent, y: center.y - halfBlockWidth))
        path3.addLine(to: center)
        path3.closeSubpath()
        paths.append(path3)
        
        var path4: Path = Path()
        path4.move(to: center)
        path4.addLine(to: CGPoint(x: center.x - halfBlockWidth + shoulderIndent, y: center.y + halfBlockWidth))
        path4.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y + halfBlockWidth))
        path4.addLine(to: CGPoint(x: center.x - halfBlockWidth, y: center.y + halfBlockWidth + shoulderIndent))
        path4.addLine(to: CGPoint(x: center.x, y: center.y + blockWidth))
        path4.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y + halfBlockWidth + shoulderIndent))
        path4.addLine(to: CGPoint(x: center.x + halfBlockWidth, y: center.y + halfBlockWidth))
        path4.addLine(to: CGPoint(x: center.x + halfBlockWidth - shoulderIndent, y: center.y + halfBlockWidth))
        path4.addLine(to: center)
        path4.closeSubpath()
        paths.append(path4)
        
        return paths
    }
}

#Preview {
    BlackAndWhiteBlocksView(blockWidth: 32)
}
