//
//  RegularPolygonsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/25/25.
//

import SwiftUI

struct RegularPolygonsView: View {
    let objectRadius: CGFloat

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / objectRadius
                let columns: CGFloat = size.width / objectRadius
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        let center: CGPoint = CGPoint(x: Double(column) * objectRadius * 2.0, y: Double(row) * objectRadius * 2.0)
                        let path = RegularPolygon(radius: objectRadius, cornerCount: 8).path(in: CGRect(center: center, width: objectRadius, height: objectRadius))
                        context.fill(path, with: .color(.red))
                    }
                }
            }
        }
    }
}

#Preview {
    RegularPolygonsView(objectRadius: 32.0)
}
