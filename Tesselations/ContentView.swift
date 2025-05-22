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
                        NorthSouthHexagonsView()
                    } label: {
                        Text("Hexagons - North/South")
                    }

                    NavigationLink {
                        EastWestHexagonsView()
                    } label: {
                        Text("Hexagons - East/West")
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
