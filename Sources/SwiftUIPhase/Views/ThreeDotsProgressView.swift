//
//  ThreeDotsProgress.swift
//  BumpSim
//
//  Created by Jeremy Vineyard on 8/24/20.
//  Copyright © 2020 Coin Bump. All rights reserved.
//

import Foundation
import SwiftUI

/// Animates three progress dots for indeterminate progress
public struct ThreeDotsProgressView: View {
    public struct Configuration {
        let animationTime: Double
        let minDotScale: CGFloat
        let maxDotScale: CGFloat
        let spacingFactor: CGFloat

        public static let `default` = Configuration(
            animationTime: 0.6,
            minDotScale: 0.9,
            maxDotScale: 1.0,
            spacingFactor: 1.0
        )
    }

    public let dotSize: CGFloat
    public let configuration: Configuration

    @State private var dotsOn = [false, false, false]

    private class MutableModel {
        var nowDate = Date()
        var animatingIndex = 0
        var accumulatedTime = 0.0
    }
    private let mutableModel = MutableModel()

    private static let timerTick = 1.0/60.0
    private let timerPublisher = Timer.publish(every: timerTick, on: .main, in: .common).autoconnect()

    public init(dotSize: CGFloat = 8.0,
                configuration: Configuration = .default) {
        self.dotSize = dotSize
        self.configuration = configuration
    }

    public var body: some View {
        HStack(alignment: .center, spacing: dotSize*configuration.spacingFactor) {
            ForEach(0..<dotsOn.count) { index in
                let isDotOn = dotsOn[index]
                DotView(color: Color(isDotOn ? .lightGray : .clear))
                    .frame(width: dotSize, height: dotSize, alignment: .center)
                    .scaleEffect(isDotOn ? configuration.maxDotScale : configuration.minDotScale, anchor: .center)
            }
        }
        .onReceive(timerPublisher) { time in
            let deltaTime = time.timeIntervalSince(mutableModel.nowDate)
            mutableModel.nowDate = time

            mutableModel.accumulatedTime += deltaTime

            // Overlap the animations
            if mutableModel.accumulatedTime >= configuration.animationTime/2.0 {
                mutableModel.accumulatedTime = 0

                withAnimation(.easeInOut(duration: configuration.animationTime)) {
                    dotsOn[mutableModel.animatingIndex].toggle()
                    mutableModel.animatingIndex += 1

                    if mutableModel.animatingIndex >= dotsOn.count {
                        mutableModel.animatingIndex = 0
                    }
                }
            }
        }
    }
}

/// Simple dot view
public struct DotView: View {
    let color: Color

    public var body: some View {
        Circle()
            .fill(color)
    }
}

struct ThreeDotsProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ThreeDotsProgressView(dotSize: 8.0, configuration: .default)
                Spacer()
            }
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
    }
}
