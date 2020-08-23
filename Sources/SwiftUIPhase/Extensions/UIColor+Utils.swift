//
//  UIColor+Utils.swift
//  SwiftUIPhase
//
//  Created by Jeremy Vineyard on 8/14/20.
//

import Foundation
import UIKit

extension UIColor {
    public func brightenedBy(_ amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        brightness = min(1.0, max(0, brightness + amount))

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    public func saturatedBy(_ amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        saturation = min(1.0, max(0, saturation + amount))

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}
