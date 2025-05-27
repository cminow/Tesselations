//
//  ContentView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/22/25.
//

import SwiftUI

struct ContentView: View {
    let frameWidth: CGFloat = 40.0

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    NavigationLink {
                        TrianglesView(hexRadius: 32.0)
                    } label: {
                        HStack {
                            TrianglesView(hexRadius: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Triangles")
                        }
                    }

                    NavigationLink {
                        NorthSouthHexagonsView(hexRadius: 16.0)
                    } label: {
                        HStack {
                            NorthSouthHexagonsView(hexRadius: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Hexagons - North/South")
                        }
                    }

                    NavigationLink {
                        EastWestHexagonsView(hexRadius: 16.0)
                    } label: {
                        HStack {
                            EastWestHexagonsView(hexRadius: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Hexagons - East/West")
                        }
                    }

                    NavigationLink {
                        SpikeyBlocksView(radius: 16.0)
                    } label: {
                        HStack {
                            SpikeyBlocksView(radius: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Spikey Blocks")
                        }
                    }

                    NavigationLink {
                        ArcsView(radius: 32.0)
                    } label: {
                        HStack {
                            ArcsView(radius: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Wavy Arcs")
                        }
                    }
                    
                    NavigationLink {
                        RectanglesAndFourPointStarsView(blockWidth: 32.0)
                    } label: {
                        HStack {
                            RectanglesAndFourPointStarsView(blockWidth: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Rects and Stars")
                        }
                    }

                    NavigationLink {
                        InterlockingYsView(hexRadius: 16.0)
                    } label: {
                        HStack {
                            InterlockingYsView(hexRadius: 4.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Interlocking Ys")
                        }
                    }

                    NavigationLink {
                        OctagonsAndDiamondsView(blockWidth: 32.0)
                    } label: {
                        HStack {
                            OctagonsAndDiamondsView(blockWidth: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Octagons and Diamonds")
                        }
                    }

                    NavigationLink {
                        RoundInterlockedHexView(hexRadius: 32.0)
                    } label: {
                        HStack {
                            RoundInterlockedHexView(hexRadius: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Round Hex Interlock")
                        }
                    }

                    NavigationLink {
                        SixSidedRosetteView(hexRadius: 64.0)
                    } label: {
                        HStack {
                            SixSidedRosetteView(hexRadius: 32.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Six-sided Rosette")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                
            }            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
