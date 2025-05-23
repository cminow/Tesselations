//
//  ArcsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/23/25.
//

import SwiftUI

struct ArcsView: View {
    var radius: CGFloat = 32.0

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / radius
                let columns: CGFloat = size.width / radius
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        let center: CGPoint = CGPoint(x: Double(column) * radius * 2.0, y: Double(row) * radius * 2.0)
                        let arcsPath: Path = arcsPath(center: center, radius: radius * 1.0)
                        let brightness: Double = .random(in: 0.5...0.75)
                        context.fill(arcsPath, with: .color(.init(hue: 0.0,
                                                                  saturation: 0.0,
                                                                  brightness: brightness,
                                                                  opacity: 1.0)))
                        context.stroke(arcsPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: 0.450)), lineWidth: 1.0)
                    }
                }
            }
        }
    }

    func arcsPath(center: CGPoint, radius: CGFloat) -> Path {
        let halfRadius: CGFloat = radius / 2.0
        var path: Path = Path()
        
        path.move(to: CGPoint(x: center.x - radius, y: center.y - radius))
        path.addArc(center: CGPoint(x: center.x - halfRadius, y: center.y - radius), radius: halfRadius, startAngle: Angle(degrees: 180.0), endAngle: Angle(degrees: 360.0), clockwise: false)
        path.addArc(center: CGPoint(x: center.x + halfRadius, y: center.y - radius), radius: halfRadius, startAngle: (Angle(degrees: 180.0)), endAngle: Angle(degrees: 360.0), clockwise: true)
        path.addArc(center: CGPoint(x: center.x + radius, y: center.y - halfRadius), radius: halfRadius, startAngle: (Angle(degrees: -90.0)), endAngle: Angle(degrees: 90.0), clockwise: false)
        path.addArc(center: CGPoint(x: center.x + radius, y: center.y + halfRadius), radius: halfRadius, startAngle: (Angle(degrees: -90.0)), endAngle: Angle(degrees: 90.0), clockwise: true)
        path.addArc(center: CGPoint(x: center.x + halfRadius, y: center.y + radius), radius: halfRadius, startAngle: (Angle(degrees: 0.0)), endAngle: Angle(degrees: 180.0), clockwise: false)
        path.addArc(center: CGPoint(x: center.x - halfRadius, y: center.y + radius), radius: halfRadius, startAngle: (Angle(degrees: 0.0)), endAngle: Angle(degrees: 180.0), clockwise: true)
        path.addArc(center: CGPoint(x: center.x - radius, y: center.y + halfRadius), radius: halfRadius, startAngle: (Angle(degrees: 90.0)), endAngle: Angle(degrees: -90.0), clockwise: false)
        path.addArc(center: CGPoint(x: center.x - radius, y: center.y - halfRadius), radius: halfRadius, startAngle: (Angle(degrees: 90.0)), endAngle: Angle(degrees: -90.0), clockwise: true)
        
        return path
    }
}

#Preview {
    ArcsView(radius: 32.0)
}
