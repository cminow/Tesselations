//
//  BlackAndWhiteBlocksContainerView.swift
//  Tessellations macOS
//
//  Created by Charlie Minow on 6/18/25.
//

import SwiftUI

struct BlackAndWhiteBlocksContainerView: View {
    var body: some View {
        HStack {
            ZStack {
                BlackAndWhiteBlocksView(blockWidth: 32.0, shoulderDivisor: 6.0)
                VStack {
                    HStack {
                        Text("Shoulder divisor: 6.0")
                            .padding(4.0)
                            .background {
                                RoundedRectangle(cornerRadius: 4.0)
                                    .fill(.windowBackground)
                            }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
            .padding([.trailing])
            
            ZStack {
                BlackAndWhiteBlocksView(blockWidth: 32.0, shoulderDivisor: 4.0)
                VStack {
                    HStack {
                        Text("Shoulder divisor: 4.0")
                            .padding(4.0)
                            .background {
                                RoundedRectangle(cornerRadius: 4.0)
                                    .fill(.windowBackground)
                            }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
            .padding([.trailing])

            ZStack {
                BlackAndWhiteBlocksView(blockWidth: 32.0, shoulderDivisor: 3.0)
                VStack {
                    HStack {
                        Text("Shoulder divisor: 3.0")
                            .padding(4.0)
                            .background {
                                RoundedRectangle(cornerRadius: 4.0)
                                    .fill(.windowBackground)
                            }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    BlackAndWhiteBlocksContainerView()
}
