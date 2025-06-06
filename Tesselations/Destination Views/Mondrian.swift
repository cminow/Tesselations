//
//  Mondrian.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/5/25.
//

import SwiftUI

struct Mondrian: View {
    @State private var depth: Int = 4
    @State private var remainder: Int = .random(in: 0...1)
    
    private var colors: [Color] = [
        .red, .red,
        .blue, .blue,
        .yellow, .yellow,
        .white, .white, .white, .white, .white, .white, .white
    ]

    var body: some View {
        VStack {
            Canvas { context, size in

                drawRect(x: 0.0,
                         y: 0.0,
                         width: size.width,
                         height: size.height,
                         depth: depth,
                         context: context)
            }
            .onTapGesture {
                remainder = (remainder + 1) % 2
            }
        }
    }

    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                depth = 3
        }
    }
    
    private func drawRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, depth: Int, context: GraphicsContext) {
        if depth > 0 {
            if depth % 2 == remainder {
                // Vertical split
//                print("Vertical: \(depth)")
                let sizePercentage: Double = .random(in: 0.3...0.8)
                drawRect(x: x,
                         y: y,
                         width: width * sizePercentage,
                         height: height,
                         depth: depth - 1,
                         context: context)
                drawRect(x: x + width * sizePercentage,
                         y: y,
                         width: width * (1 - sizePercentage),
                         height: height,
                         depth: depth - 1,
                         context: context)
            } else {
                // Horizontal split:
//                print("Horizontal: \(depth)")
                let sizePercentage: Double = .random(in: 0.3...0.8)
                drawRect(x: x,
                         y: y,
                         width: width,
                         height: height * sizePercentage,
                         depth: depth - 1,
                         context: context)
                drawRect(x: x,
                         y: y + (height * sizePercentage),
                         width: width,
                         height: height * (1 - sizePercentage),
                         depth: depth - 1,
                         context: context)
            }
        } else {
            let rect = CGRect(x: x, y: y, width: width, height: height)
            let path: Path = Path(rect)
            context.fill(path, with: .color(colors[Int.random(in: 0...colors.count - 1)]))
            var lineWidth: CGFloat = 8.0
            if context.clipBoundingRect.width < 128 {
                lineWidth = 2.0
            }
            context.stroke(path, with: .color(.black), style: .init(lineWidth: lineWidth))
        }
            
    }
}

#Preview {
    Mondrian()
}
