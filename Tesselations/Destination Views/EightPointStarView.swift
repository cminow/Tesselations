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
                        
                        context.stroke(mainStarPath, with: .color(.gray), style: strokeStyle)
                    }
                }
            }
        }
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
    EightPointStarView(blockWidth: 64)
}
