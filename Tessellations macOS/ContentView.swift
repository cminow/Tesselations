//
//  ContentView.swift
//  Tessellations macOS
//
//  Created by Charlie Minow on 6/1/25.
//

import SwiftUI

struct ContentView: View {
    let frameWidth: CGFloat = 40.0

    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("Tessellations")) {

                    NavigationLink {
                        HeratMinaretOctagramView(blockWidth: 64.0)
                    } label: {
                        HStack {
                            HeratMinaretOctagramView(blockWidth: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Herat Minaret")
                        }
                    }

                    NavigationLink {
                        HexWeaveView(radius: 64.0)
                    } label: {
                        HStack {
                            HexWeaveView(radius: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Hexagonal Weave")
                        }
                    }

                    NavigationLink {
                        WavyTrianglesView(radius: 16.0)
                    } label: {
                        HStack {
                            WavyTrianglesView(radius: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Wavy Triangles")
                        }
                    }

                    NavigationLink {
                        BlackAndWhiteBlocksContainerView()
                    } label: {
                        HStack {
                            BlackAndWhiteBlocksView(blockWidth: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Alternating Blocks")
                        }
                    }

                    NavigationLink {
                        AlternatingOctagonalStarsView(radius: 32.0)
                    } label: {
                        HStack {
                            AlternatingOctagonalStarsView(radius: 32.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Alternating Octagonal Stars")
                        }
                    }

                    NavigationLink {
                        SquaresAndStars(radius: 32.0)
                    } label: {
                        HStack {
                            SquaresAndStars(radius: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Squares and Stars")
                        }
                    }

                    NavigationLink {
                        TwelvePointStarView(radius: 64)
                    } label: {
                        HStack {
                            TwelvePointStarView(radius: 24.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Twelve-Pointed Star")
                        }
                    }

                    NavigationLink {
                        HexagonalLatticeView(radius: 128.0)
                    } label: {
                        HStack {
                            HexagonalLatticeView(radius: 24.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Hexagonal Lattice")
                        }
                    }

                    NavigationLink {
                        SixPointedStarView(radius: 48.0)
                    } label: {
                        HStack {
                            SixPointedStarView(radius: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Six-Pointed Star")
                        }
                    }

                    NavigationLink {
                        SixSidedRosetteView(hexRadius: 64.0)
                    } label: {
                        HStack {
                            SixSidedRosetteView(hexRadius: 32.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Six-Sided Rosette")
                        }
                    }

                    NavigationLink {
                        EightPointStarView(blockWidth: 48.0)
                    } label: {
                        HStack {
                            EightPointStarView(blockWidth: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Eight-Pointed Star")
                        }
                    }

                    NavigationLink {
                        MoreHexagons(radius: 64.0)
                    } label: {
                        HStack {
                            MoreHexagons(radius: 32.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("More Hexagons")
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
                        OctagonsAndStarsView(radius: 32.0)
                    } label: {
                        HStack {
                            OctagonsAndStarsView(radius: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Octagons and Stars")
                        }
                    }
                    
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
                        OctagonsAndDiamondsView(blockWidth: 32.0)
                    } label: {
                        HStack {
                            OctagonsAndDiamondsView(blockWidth: 16.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Octagons and Diamonds")
                        }
                    }
                }
                
                Section(header: Text("Non-Tessellated Patterns")) {
                    NavigationLink {
                        Mondrian()
                    } label: {
                        HStack {
                            Mondrian()
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Mondrian")
                        }
                    }

                    NavigationLink {
                        HalfCirclesView(radius: 24.0)
                    } label: {
                        HStack {
                            HalfCirclesView(radius: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Half Circles Pattern")
                        }
                    }

                    NavigationLink {
                        WavyTrianglesAlternateView(radius: 64.0)
                    } label: {
                        HStack {
                            WavyTrianglesAlternateView(radius: 8.0)
                                .frame(width: frameWidth, height: frameWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Alternate Wavy Triangles")
                        }
                    }
                }
            }
        } detail: {
            Text("Select a Tessellation")
        }
        .listStyle(.sidebar)
    }
}

#Preview {
    ContentView()
}
