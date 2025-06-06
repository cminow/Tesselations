//
//  TempTestView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/6/25.
//

import SwiftUI

struct TempTestView: View {
    var body: some View {
        VStack {
            Canvas { context, size in
                context.translateBy(x: size.width / 2.0, y: size.height / 2.0)
                let layoutCircle1: LayoutCircle = LayoutCircle(center: .zero, radius: 250.0)
                context.stroke(layoutCircle1.inscribedOctagon.stellatedPath, with: .color(.red), style: .init(lineWidth: 4.0))
                context.stroke(layoutCircle1.inscribedOctagon.secondStellatedPath, with: .color(.purple), style: .init(lineWidth: 4.0))
                context.stroke(layoutCircle1.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                context.stroke(layoutCircle1.inscribedOctagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                context.stroke(layoutCircle1.inscribedSquare.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
                
                let layoutCircle2: LayoutCircle = LayoutCircle(center: .zero, radius: 250.0, inscribedPolygonInitialAngle: .degrees(45.0))
                context.stroke(layoutCircle2.inscribedSquare.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
                let layoutCircle3: LayoutCircle = LayoutCircle(center: .zero, radius: 250.0 * 0.765)
                context.stroke(layoutCircle3.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
            }
        }
    }
}

#Preview {
    TempTestView()
}
