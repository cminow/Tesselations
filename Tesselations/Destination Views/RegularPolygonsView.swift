//
//  RegularPolygonsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/25/25.
//

import SwiftUI

struct RegularPolygonsView: View {
    var body: some View {
        VStack {
            Canvas { context, size in
                let center: CGPoint = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
                let path = RegularPolygon(radius: 100, cornerCount: 8).path(in: CGRect(center: center, width: 100, height: 100))
                context.fill(path, with: .color(.red))
            }
            
        }
    }
}

#Preview {
    RegularPolygonsView()
}
