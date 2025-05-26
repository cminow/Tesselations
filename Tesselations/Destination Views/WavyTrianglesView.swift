//
//  WavyTrianglesView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/26/25.
//

import SwiftUI

struct WavyTrianglesView: View {
    var radius: CGFloat
    let halfSqrt3: CGFloat = sqrt(3.0) / 2.0
    
    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0
                        if row % 2 == 1 {
                            rowOffset -= radius * halfSqrt3
                        }
                        
                        let center = CGPoint(x: Double(column) * (halfSqrt3 * 2.0) * radius + rowOffset, y: Double(row) * radius * 1.5)
                        let path = trianglePath(center: center, radius: radius)
                        context.fill(path, with: .color(.red))
                        
                        let flattops = trianglePath(center: CGPoint(x: center.x + (radius * halfSqrt3),
                                                                    y: center.y - (radius * 0.5)),
                                                    radius: -radius)
                        context.fill(flattops, with: .color(.blue))
                    }
                }
            }
        }
    }
    
    private func trianglePath(center: CGPoint, radius: CGFloat) -> Path {
        var path = Path()
        
        path.move(to: triangleCorner(center: center, radius: radius, cornerIndex: 0))
        path.addLine(to: triangleCorner(center: center, radius: radius, cornerIndex: 1))
        path.addLine(to: triangleCorner(center: center, radius: radius, cornerIndex: 2))
        path.addLine(to: triangleCorner(center: center, radius: radius, cornerIndex: 0))
        path.closeSubpath()
        
        return path
    }
    
    private func triangleCorner(center: CGPoint, radius: CGFloat, cornerIndex: Int) -> CGPoint {
        let perStepAngle: CGFloat = (2.0 * .pi) / 3.0
        let angleRadians: CGFloat = perStepAngle * Double(cornerIndex) - (.pi * 0.5)
        let corner = CGPoint(
            x: center.x + radius * cos(angleRadians),
            y: center.y + radius * sin(angleRadians)
        )
        return corner
    }
}

#Preview {
    WavyTrianglesView(radius: 16)
}
