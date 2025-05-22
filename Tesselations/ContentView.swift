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
