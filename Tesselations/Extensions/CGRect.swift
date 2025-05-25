//
//  CGRect.swift
//  Tesselations
//
//  Created by Charlie Minow on 5/25/25.
//

import Foundation

extension CGRect {
    init(center: CGPoint, width: CGFloat, height: CGFloat) {
        let origin: CGPoint = CGPoint(x: center.x - width / 2.0, y: center.y - height / 2.0)
        self.init(origin: origin, size: CGSize(width: width, height: height))
    }
}
