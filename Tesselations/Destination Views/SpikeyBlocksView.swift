//
//  SpikeyBlocksView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/23/25.
//

import SwiftUI

struct SpikeyBlocksView: View {
    var radius: CGFloat = 32.0

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius

                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        let center: CGPoint = CGPoint(x: Double(column) * radius * 2.0, y: Double(row) * radius * 2.0)
                        let blockPath: Path = createSpikeyPath(center: center, radius: radius)
                        let brightness: Double = .random(in: 0.50...0.75)

                        context.fill(blockPath, with: .color(.init(hue: 0.0,
                                                                  saturation: 0.0,
                                                                  brightness: brightness,
                                                                  opacity: 1.0)))
                        context.stroke(blockPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: 0.45)), lineWidth: 1.0)
                        
                    }
                }
            }
        }
    }

    func createSpikeyPath(center: CGPoint, radius: CGFloat) -> Path {
        let halfRadius: CGFloat = radius / 2.0

        var path: Path = Path()
        path.move(to: CGPoint(x: center.x - radius, y: center.y - radius))

        // Top line
        path.addLine(to: CGPoint(x: center.x - halfRadius, y: center.y - radius - halfRadius * 0.5))
        path.addLine(to: CGPoint(x: center.x, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x + halfRadius, y: center.y - halfRadius * 1.5))

        path.addLine(to: CGPoint(x: center.x + radius, y: center.y - radius))

        // Right side
        path.addLine(to: CGPoint(x: center.x + radius + halfRadius * 0.5, y: center.y - halfRadius))
        path.addLine(to: CGPoint(x: center.x + radius, y: center.y))
        path.addLine(to: CGPoint(x: center.x + halfRadius * 1.5, y: center.y + halfRadius))

        path.addLine(to: CGPoint(x: center.x + radius, y: center.y + radius))
        
        // Bottom
        path.addLine(to: CGPoint(x: center.x + halfRadius, y: center.y + radius + halfRadius * 0.5))
        path.addLine(to: CGPoint(x: center.x, y: center.y + radius))
        path.addLine(to: CGPoint(x: center.x - halfRadius, y: center.y + halfRadius * 1.5))

        path.addLine(to: CGPoint(x: center.x - radius, y: center.y + radius))

        // Left
        path.addLine(to: CGPoint(x: center.x - radius - halfRadius * 0.5, y: center.y + halfRadius))
        path.addLine(to: CGPoint(x: center.x - radius, y: center.y))
        path.addLine(to: CGPoint(x: center.x - halfRadius * 1.5, y: center.y - halfRadius))
        
        path.addLine(to: CGPoint(x: center.x - radius, y: center.y - radius))
        path.closeSubpath()
        return path
    }
}

#Preview {
    SpikeyBlocksView(radius: 32.0)
}
