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
                let layoutCircle1: LayoutCircle = LayoutCircle(center: center, radius: blockWidth, inscribedPolygonInitialAngle: .degrees(45.0))
                context.stroke(layoutCircle1.inscribedSquare.path, with: .color(.cyan), style: .init(lineWidth: 1.0))

                let hypotenuse: CGFloat = blockWidth
                let shortSide: CGFloat = (hypotenuse * .sqrt3) / 2.0
                let longSide: CGFloat = hypotenuse / 2.0
                
                let newHypotenuse: CGFloat = shortSide
                let newShortSide: CGFloat = (newHypotenuse * .sqrt3) / 2.0
                let newLongSide: CGFloat = newHypotenuse / 2.0
                
                
                for index in 1...4 {
                    var path: Path = Path()
                    let point1: CGPoint = CGPoint(
                        x: layoutCircle1.inscribedSquare.points[0].x,
                        y: layoutCircle1.inscribedSquare.points[0].y
                    )
                    path.move(to: point1)
                    
                    let point2: CGPoint = CGPoint(
                        x: center.x + blockWidth / 1.9 - newShortSide / 2.0,
                        y: center.y - newLongSide
                    )
                    path.addLine(to: point2)
                    let point3: CGPoint = CGPoint(
                        x: layoutCircle1.inscribedSquare.points[3].x,
                        y: layoutCircle1.inscribedSquare.points[3].y
                    )
                    path.addLine(to: point3)
                    path.addLine(to: point1)
                    
                    context.stroke(path, with: .color(.black), style: .init(lineWidth: 6.0, lineJoin: .round))
                    context.rotate(by: .degrees(Double(index) * 90.0))
                    
                }
                
                

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
    BlackAndWhiteBlocksView(blockWidth: 64)
}
