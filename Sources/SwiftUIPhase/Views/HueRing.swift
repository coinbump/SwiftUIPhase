//
//  HueRing.swift
//  BumpSim
//
//  Created by Jeremy Vineyard on 8/23/20.
//  Copyright © 2020 Coin Bump. All rights reserved.
//

import Foundation
import SwiftUI

/// Renders a ring with a hue shift across it.
public struct HueRing: View {
    let lineWidth: CGFloat
    private let colors: [Color]

    // FUTURE: Specify first hue
    public init(lineWidth: CGFloat = 10.0) {
        self.lineWidth = lineWidth

        let colorSteps = 36

        var colors = [UIColor]()
        for i in 0..<colorSteps {
            let color = UIColor(hue: CGFloat(1.0/Double(colorSteps)*Double(i)), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            colors.append(color)
        }
        self.colors = colors.map { Color($0) }
    }

    public var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .local)
            let center = frame.center

            Path { path in
                path.addArc(center: center, radius: geometry.size.width/2.0 - lineWidth/2.0, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 360.0), clockwise: true)
            }
            .stroke(lineWidth: lineWidth)
            .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: Angle(degrees: 360.0)))
        }
    }
}

struct HueRing_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            HueRing(lineWidth: 10.0)
                .frame(width: 100, height: 100, alignment: .center)
            HueRing(lineWidth: 10.0)
                .frame(width: 100, height: 100, alignment: .center)
            HueRing(lineWidth: 10.0)
                .frame(width: 100, height: 100, alignment: .center)
        }
        .background(Color(.systemBackground))
    }
}
