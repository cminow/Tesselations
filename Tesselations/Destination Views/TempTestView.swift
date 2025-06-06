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
                var layoutCircle1: LayoutCircle = LayoutCircle(center: .zero, radius: 150.0)
                context.stroke(layoutCircle1.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                context.stroke(layoutCircle1.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                
                layoutCircle1.inscribedPathDirection = .northSouth
                context.stroke(layoutCircle1.inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
            }
        }
    }
}

#Preview {
    TempTestView()
}
