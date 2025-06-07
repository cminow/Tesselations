//
//  OctagonsAndDiamondsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/25/25.
//

import SwiftUI

struct OctagonsAndDiamondsView: View {
    var blockWidth: CGFloat
    var cornerInset: CGFloat {
        return blockWidth * 0.33333
    }
    var body: some View {
        VStack {
            Canvas(rendersAsynchronously: true) { context, size in
                let rows = size.height / blockWidth
                let columns = size.width / blockWidth
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        let center = CGPoint(x: Double(column) * blockWidth, y: Double(row) * blockWidth)
                        let octagonPath: Path = octagon(center: center, width: blockWidth, cornerInset: cornerInset)
                        let octagonBrightness: Double = .random(in: 0.80...0.9)

                        context.fill(octagonPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: octagonBrightness)))
                        

                        let diamondPath: Path = diamond(center: center, blockWidth: blockWidth / 2.0, cornerInset: cornerInset)
                        let diamondBrightness: Double = .random(in: 0.550...0.75)
                        context.fill(diamondPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: diamondBrightness)))
                        
                        context.stroke(octagonPath, with: .color(.gray), style: .init(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                        context.stroke(diamondPath, with: .color(.gray), style: .init(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                    }
                }
            }
        }
    }
    private func octagon(center: CGPoint, width: CGFloat, cornerInset: CGFloat) -> Path {
        let halfWidth: CGFloat = width / 2.0
        var path = Path()
        
        path.move(to: CGPoint(x: center.x - halfWidth + cornerInset, y: center.y - halfWidth))
        path.addLine(to: CGPoint(x: center.x + halfWidth - cornerInset, y: center.y - halfWidth))
        path.addLine(to: CGPoint(x: center.x + halfWidth, y: center.y - halfWidth + cornerInset))
        path.addLine(to: CGPoint(x: center.x + halfWidth, y: center.y + halfWidth - cornerInset))
        path.addLine(to: CGPoint(x: center.x + halfWidth - cornerInset, y: center.y + halfWidth))
        path.addLine(to: CGPoint(x: center.x - halfWidth + cornerInset, y: center.y + halfWidth))
        path.addLine(to: CGPoint(x: center.x - halfWidth, y: center.y + halfWidth -  cornerInset))
        path.addLine(to: CGPoint(x: center.x - halfWidth, y: center.y - halfWidth + cornerInset))
        path.addLine(to: CGPoint(x: center.x - halfWidth + cornerInset, y: center.y - halfWidth))
        path.closeSubpath()
        
        return path
    }

    private func diamond(center: CGPoint, blockWidth: CGFloat, cornerInset: CGFloat) -> Path {
        let dCenter: CGPoint = CGPoint(x: center.x + blockWidth, y: center.y + blockWidth)
        var path: Path = Path()
        
        path.move(to: CGPoint(x: dCenter.x, y: dCenter.y - cornerInset))
        path.addLine(to: CGPoint(x: dCenter.x + cornerInset, y: dCenter.y))
        path.addLine(to: CGPoint(x: dCenter.x, y: dCenter.y + cornerInset))
        path.addLine(to: CGPoint(x: dCenter.x -  cornerInset, y: dCenter.y))
        path.addLine(to: CGPoint(x: dCenter.x, y: dCenter.y - cornerInset))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    OctagonsAndDiamondsView(blockWidth: 64)
}
