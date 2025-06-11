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
                context.translateBy(x: size.width / 2.0, y: size.height / 2.0)

                let center: CGPoint = .zero
                let layoutCircle1: LayoutCircle = LayoutCircle(center: center, radius: blockWidth, inscribedPolygonInitialAngle: .degrees(45))
                context.stroke(layoutCircle1.inscribedSquare.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
                let newCenter: CGPoint = CGPoint(x: center.x + blockWidth / sqrt(2) / 16, y: center.y + blockWidth *  sqrt(2) / 2.0)
                let layoutCircle2: LayoutCircle = LayoutCircle(center: newCenter, radius: blockWidth / 1.50)
                context.stroke(layoutCircle2.inscribedTriangle.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
                let newCenter2: CGPoint = CGPoint(x: center.x - blockWidth / sqrt(2) / 16, y: center.y - blockWidth *  sqrt(2) / 2.0)
                let layoutCircle3: LayoutCircle = LayoutCircle(center: newCenter2, radius: -blockWidth / 1.50)
                context.stroke(layoutCircle3.inscribedTriangle.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
                let newCenter3: CGPoint = CGPoint(x: center.x - blockWidth *  sqrt(2) / 2.0, y: center.y + blockWidth / sqrt(2) / 16)
                let layoutCircle4: LayoutCircle = LayoutCircle(center: newCenter3, radius: blockWidth / 1.50, inscribedPolygonInitialAngle: .degrees(-30))
                context.stroke(layoutCircle4.inscribedTriangle.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
                let newCenter4: CGPoint = CGPoint(x: center.x + blockWidth *  sqrt(2) / 2.0, y: center.y - blockWidth / sqrt(2) / 16)
                let layoutCircle5: LayoutCircle = LayoutCircle(center: newCenter4, radius: -blockWidth / 1.50, inscribedPolygonInitialAngle: .degrees(-30))
                context.stroke(layoutCircle5.inscribedTriangle.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
//                for row in 0...Int(rows) {
//                    for column in 0...Int(columns) {
//                        
//                    }
//                }
            }
        }
    }
}

#Preview {
    BlackAndWhiteBlocksView(blockWidth: 128.0)
}
