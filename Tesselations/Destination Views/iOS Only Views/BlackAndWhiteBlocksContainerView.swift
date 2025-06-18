//
//  BlackAndWhiteBlocksContainerView.swift
//  Tessellations
//
//  Created by Charlie Minow on 6/18/25.
//

import SwiftUI

struct BlackAndWhiteBlocksContainerView: View {
    @State private var shoulderDivisor: CGFloat = 3.0

    var body: some View {
        VStack {
            BlackAndWhiteBlocksView(blockWidth: 48.0, shoulderDivisor: shoulderDivisor)

            Text("Value: \(shoulderDivisor, format: .number.precision(.significantDigits(2...3)))")

            Slider(value: $shoulderDivisor, in: 2.25...12.0) {
               Text("Shoulder Value")
            } minimumValueLabel: {
                Text("2.25")
            } maximumValueLabel: {
                Text("12.0")
            }
            .padding()
            
        }
        
    }
}

#Preview {
    BlackAndWhiteBlocksContainerView()
}
