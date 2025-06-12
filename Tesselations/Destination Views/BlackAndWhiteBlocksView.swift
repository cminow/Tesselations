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
                        let layoutCircle1: LayoutCircle = LayoutCircle(center: center, radius: blockWidth, inscribedPolygonInitialAngle: .degrees(45.0))

                        let shoulderIndent: CGFloat = blockWidth / 6.0
                        let halfBlockWidth: CGFloat = blockWidth / 2.0
                        
                        for _ in 0...1 {
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
                            context.fill(path, with: .color(.black))
                            
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
                            context.fill(path2, with: .color(.black))
                            
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
                            context.fill(path3, with: .color(.blue))
                            
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
                            context.fill(path4, with: .color(.blue))
                            
                            center.x += blockWidth
                            center.y += blockWidth
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BlackAndWhiteBlocksView(blockWidth: 32)
}
