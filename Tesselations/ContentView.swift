//
//  ContentView.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/22/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    NavigationLink {
                        TrianglesView(hexRadius: 32.0)
                    } label: {
                        HStack {
                            TrianglesView(hexRadius: 8.0)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Triangles")
                        }
                    }

                    NavigationLink {
                        NorthSouthHexagonsView(hexRadius: 16.0)
                    } label: {
                        HStack {
                            NorthSouthHexagonsView(hexRadius: 8.0)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Hexagons - North/South")
                        }
                    }

                    NavigationLink {
                        EastWestHexagonsView(hexRadius: 16.0)
                    } label: {
                        HStack {
                            EastWestHexagonsView(hexRadius: 8.0)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Hexagons - East/West")
                        }
                    }

                    NavigationLink {
                        SpikeyBlocksView(radius: 16.0)
                    } label: {
                        HStack {
                            SpikeyBlocksView(radius: 8.0)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Spikey Blocks")
                        }
                    }

                    NavigationLink {
                        ArcsView(radius: 32.0)
                    } label: {
                        HStack {
                            ArcsView(radius: 8.0)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Wavy Arcs")
                        }
                    }
                    
                    NavigationLink {
                        RectanglesAndFourPointStarsView(blockWidth: 32.0)
                    } label: {
                        HStack {
                            RectanglesAndFourPointStarsView(blockWidth: 8.0)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text("Rects and Stars")
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
