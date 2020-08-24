//
//  ProgressBar.swift
//  SwiftUIPhase
//
//  Created by Jeremy Vineyard on 8/23/20.
//

import Foundation
import SwiftUI

private enum Constants {
    static let progressBarHeight: CGFloat = 4.0
}

/// ProgressView is only available in iOS 14, this gives us one for iOS 13
// FUTURE: support label
public struct ProgressBar<Label>: View where Label: View {
    let value: Double
    let total: Double

    public init(value: Double, total: Double = 1.0) where Label == EmptyView {
        self.value = value
        self.total = total
    }

    public var body: some View {
        if #available(iOS 14.0, *) {
            ProgressView(value: value, total: total)
        }
        else {
            ZStack {
                GeometryReader { geometry in
                    Capsule()
                        .fill(Color(.systemGray5))
                    Capsule()
                        .fill(Color(.systemBlue))
                        .frame(width: geometry.size.width*CGFloat(value), height: nil, alignment: .center)
                }
            }
            .drawingGroup()
            .frame(minWidth: nil, idealWidth: nil, maxWidth: .infinity, minHeight: Constants.progressBarHeight, idealHeight: Constants.progressBarHeight, maxHeight: Constants.progressBarHeight, alignment: .center)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.5, total: 1.0)
    }
}
