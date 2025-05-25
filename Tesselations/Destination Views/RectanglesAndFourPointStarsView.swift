//
//  RectanglesAndFourPointStarsView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/25/25.
//

import SwiftUI

struct RectanglesAndFourPointStarsView: View {
    var blockWidth: CGFloat = 64.0
    let strokeStyle: StrokeStyle = .init(lineWidth: 2.0, lineCap: .round, lineJoin: .round)

    var body: some View {
        VStack {
            Canvas { context, size in
                let rows: CGFloat = size.height / blockWidth
                let columns: CGFloat = size.width / blockWidth

                var center: CGPoint = CGPoint(x: 0.0, y: 0.0)
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        center.x = Double(column) * blockWidth * 1.25
                        center.y = Double(row) * blockWidth * 1.25
                        let rect = CGRect(x: center.x - blockWidth / 2.0, y: center.y - blockWidth / 2.0, width: blockWidth, height: blockWidth)
                        let rectPath = Rectangle().path(in: rect)
                        
                        let brightness: Double = .random(in: 0.5...0.75)
                        context.fill(rectPath, with: .color(.init(hue: 0.0, saturation: 0.0, brightness: brightness)))
                        context.stroke(rectPath, with: .color(.gray), style: strokeStyle)
                        
                        var starBrightness: Double = 0.0

                        if row % 2 == 0 && column % 2 == 0 {
                            starBrightness = 0.0
                            let starPath: Path = starPath(center: center, blockWidth: blockWidth)
                            context.fill(starPath, with: .color(.init(hue: 0.0, saturation: 1.0, brightness: starBrightness)))
                        }

                        if row % 2 == 1 && column % 2 == 1 {
                            starBrightness = 0.2
                            let starPath: Path = starPath(center: center, blockWidth: blockWidth)
                            context.fill(starPath, with: .color(.init(hue: 0.333, saturation: 1.0, brightness: starBrightness)))
                        }
                        
                        if row % 2 == 1 && column % 2 == 0 {
                            starBrightness = 0.40
                            let starPath: Path = starPath(center: center, blockWidth: blockWidth)
                            context.fill(starPath, with: .color(.init(hue: 0.6667, saturation: 1.0, brightness: starBrightness)))
                        }
                        
                        if row % 2 == 0 && column % 2 == 1 {
                            starBrightness = 0.60
                            let starPath: Path = starPath(center: center, blockWidth: blockWidth)
                            context.fill(starPath, with: .color(.init(hue: 0.8, saturation: 1.0, brightness: starBrightness)))
                        }
                        
                    }
                }
            }
        }
    }
    
    private func starPath(center: CGPoint, blockWidth: CGFloat) -> Path {
        print(center)
        var path: Path = Path()
        path.move(to: CGPoint(x: center.x + blockWidth / 2.0, y: center.y + blockWidth / 2.0))
        path.addLine(to: CGPoint(x: center.x + blockWidth * 0.75, y: center.y - blockWidth / 2.0))
        path.addLine(to: CGPoint(x: center.x + blockWidth * 0.75, y: center.y + blockWidth / 2.0))
        path.addLine(to: CGPoint(x: center.x + blockWidth * 1.75, y: center.y + blockWidth * 0.75))
        path.addLine(to: CGPoint(x: center.x + blockWidth * 0.75, y: center.y + blockWidth * 0.75))
        path.addLine(to: CGPoint(x: center.x +  blockWidth / 2.0, y: center.y + blockWidth * 1.75))
        path.addLine(to: CGPoint(x: center.x +  blockWidth / 2.0, y: center.y + blockWidth * 0.75))
        path.addLine(to: CGPoint(x: center.x - blockWidth / 2.0, y: center.y + blockWidth / 2.0))
        path.addLine(to: CGPoint(x: center.x + blockWidth / 2.0, y: center.y + blockWidth / 2.0))
        path.closeSubpath()
        return path
    }
}

#Preview {
    RectanglesAndFourPointStarsView()
}
