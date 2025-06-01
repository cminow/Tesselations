//
//  CGFloat.swift
//  Tessellations
//
//  Created by Charlie Minow on 5/31/25.
//

import Foundation

extension CGFloat {
    var radians: CGFloat {
        return  self * ( .pi / 180.0)
    }

    var degrees: CGFloat {
        return self * (180.0 / .pi)
    }

    static var sqrt3: CGFloat {
        return 1.7320508075688772
    }
}
