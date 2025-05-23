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
                        let blockPath: Path = createSpikeyPath(center: center, radius: radius * 0.95)
                        let brightness: Double = .random(in: 0.50...0.75)

                        context.fill(blockPath, with: .color(.init(hue: 0.0,
                                                                  saturation: 0.0,
                                                                  brightness: brightness,
                                                                  opacity: 1.0)))
                        
                    }
                }
            }
        }
    }

    func createSpikeyPath(center: CGPoint, radius: CGFloat) -> Path {
        var path: Path = Path()
        path.move(to: CGPoint(x: center.x - radius, y: center.y - radius))
//        path.addLine(to: CGPoint(x: center.x - (radius / 2.0), y: center.y - radius * 1.25))
//        path.addLine(to: CGPoint(x: center.x, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x + radius, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x + radius, y: center.y + radius))
        path.addLine(to: CGPoint(x: center.x - radius, y: center.y + radius))
        path.closeSubpath()
        return path
    }
}

#Preview {
    SpikeyBlocksView(radius: 32.0)
}
