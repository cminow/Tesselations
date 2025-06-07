//
//  TwelvePointStarView.swift
//  Tesselations
//
//  Created by Charlie Minow on 6/3/25.
//

import SwiftUI

struct TwelvePointStarView: View {
    var radius: CGFloat

    var body: some View {
        VStack {
            Canvas(rendersAsynchronously: true) { context, size in
                let rows: CGFloat = (size.height * 1.5) / radius
                let columns: CGFloat = size.width / radius
                let backgroundRect: CGRect = context.clipBoundingRect
                context.fill(Rectangle().path(in: backgroundRect), with: .color(.red))
                
                for row in 0...Int(rows) {
                    for column in 0...Int(columns) {
                        var rowOffset: CGFloat = 0.0

                        if row % 2 != 0 {
                            rowOffset = radius * .sqrt3 / 2.0
                        }
                        let center = CGPoint(x: Double(column) * radius * sqrt(3.0) + rowOffset, y: Double(row) * radius * 1.5)

                        var layoutHexagons: [Hexagon] = []
                        for layoutFactor: CGFloat in stride(from: 1.0, to: 0.0, by: -0.2) {
                            let hexagon: Hexagon = Hexagon(center: center, radius: radius * layoutFactor, direction: .northSouth)
                            layoutHexagons.append(hexagon)
//                            context.stroke(hexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0, lineCap: .round, lineJoin: .round))
                        }
                        
                        let gradient: Gradient = .init(stops: [
                                .init(color: .init(hue: 0.0, saturation: 0.750, brightness: 0.5), location: 0.250),
                                .init(color: .init(hue: 0.0, saturation: 1.0, brightness: 1.0), location: 0.850)
                                                              
                        ])
                        
                        context.fill(layoutHexagons[0].path, with: .radialGradient(gradient,
                                                                                   center: center,
                                                                                   startRadius: radius,
                                                                                   endRadius: 0.0))
                        
                        let innerHex = layoutHexagons[layoutHexagons.count - 2]
                        context.fill(innerHex.inscribedSixPointStarPath, with: .color(.black))
                        let secondStar = Hexagon(center: center, radius: innerHex.radius, direction: .eastWest)
                        context.fill(secondStar.inscribedSixPointStarPath, with: .color(.black))

                        var cornerHexagons: [Hexagon] = []
                        for _ in 0...5 {
                            let hexagon = Hexagon(center: center, radius: radius, direction: .northSouth)
                            for centerPoint: CGPoint in hexagon.points {
                                let cornerHex: Hexagon = Hexagon(center: centerPoint, radius: radius * .sqrt3 / 8.0, direction: .northSouth)
                                cornerHexagons.append(cornerHex)
//                                context.stroke(cornerHex.path, with: .color(.cyan))
                            }
                        }

                        // Just for construction:
                        var innerCornerHexagons: [Hexagon] = []
                        for _ in 0...5 {
                            let hexagon = Hexagon(center: center, radius: radius * 0.6, direction: .northSouth)
                            for centerPoint: CGPoint in hexagon.points {
                                let cornerHex: Hexagon = Hexagon(center: centerPoint, radius: radius * .sqrt3 / 8.0, direction: .northSouth)
                                innerCornerHexagons.append(cornerHex)
//                                context.stroke(cornerHex.path, with: .color(.cyan))
                            }
                        }

                        var concavePetalPaths: [Path] =  []
                        for index in 0...5 {
                            var path: Path = Path()
                            path.move(to: innerHex.points[index])
                            path.addLine(to: innerCornerHexagons[index].points[(index + 5) % 6])
                            path.addLine(to: cornerHexagons[index].points[(index + 4) % 6])
                            path.addLine(to: cornerHexagons[index].points[(index + 3) % 6])
                            path.addLine(to: cornerHexagons[index].points[(index + 2) % 6])
                            path.addLine(to: innerCornerHexagons[index].points[(index + 1) % 6])
                            path.addLine(to: innerHex.points[index])
                            path.closeSubpath()
                            
                            let brightness: Double = .random(in: 0.75...0.90)
                            context.fill(path, with: .color(.init(hue: 0.15, saturation: 1.0, brightness: brightness)))
//                            context.stroke(path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                            concavePetalPaths.append(path)
                        }

                        // Just for construction:
                        let innerEastWestHexagon = Hexagon(center: center, radius: radius * 0.4, direction: .eastWest)
//                        context.stroke(innerEastWestHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        let inscribedHexagon = Hexagon(center: center, radius: radius * .sqrt3 / 2.0, direction: .eastWest)
//                        context.stroke(inscribedHexagon.path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                        for index in 0...5 {
                            var path: Path = Path()
                            path.move(to: innerEastWestHexagon.points[index])
                            path.addLine(to: innerCornerHexagons[(index + 5) % 6].points[index])
                            path.addLine(to: inscribedHexagon.points[index])
                            path.addLine(to: innerCornerHexagons[index].points[(index + 5) % 6])
                            path.addLine(to: innerEastWestHexagon.points[index])
                            path.closeSubpath()
//                            context.stroke(path, with: .color(.cyan), style: .init(lineWidth: 1.0))
                            let brightness: Double = .random(in: 0.85...1.0)
                            context.fill(path, with: .color(.init(hue: 0.6, saturation: 0.80, brightness: brightness)))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TwelvePointStarView(radius: 128)
}
