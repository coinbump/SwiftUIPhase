//
//  File.swift
//  SwiftUIPhase
//
//  Created by Jeremy Vineyard on 8/23/20.
//

import Foundation
import SwiftUI

/// Bridge for fonts not available in iOS 13
extension Font {
    public static var title2Bridge: Font {
        if #available(iOS 14, *) {
            return .title2
        } else {
            return .title
        }
    }

    public static var title3Bridge: Font {
        if #available(iOS 14, *) {
            return .title3
        } else {
            return .title
        }
    }
}
