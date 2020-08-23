//
//  ProgressBar.swift
//  SwiftUIPhase
//
//  Created by Jeremy Vineyard on 8/23/20.
//

import Foundation
import SwiftUI

/// ProgressView is only available in iOS 14, this gives us one for iOS 13
// FUTURE: support label
struct ProgressBar: View {
    let value: Double
    let total: Double

    private enum Constants {
        static let progressBarHeight: CGFloat = 4.0
    }

    var body: some View {
        if #available(iOS 14.0, *) {
            ProgressView(value: value, total: total)
        }
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: Constants.progressBarHeight/2.0)
                    .fill(Color(.systemGray5))
                RoundedRectangle(cornerRadius: Constants.progressBarHeight/2.0)
                    .fill(Color(.systemBlue))
                    .frame(width: geometry.size.width*CGFloat(value), height: nil, alignment: .center)
            }
        }
        .drawingGroup()
        .frame(minWidth: nil, idealWidth: nil, maxWidth: .infinity, minHeight: Constants.progressBarHeight, idealHeight: Constants.progressBarHeight, maxHeight: Constants.progressBarHeight, alignment: .center)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.5, total: 1.0)
    }
}
