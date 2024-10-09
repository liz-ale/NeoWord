//
//  WinAnimationView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 09/10/24.
//
import SwiftUI
import Lottie

struct WinAnimationView: View {
    @Binding var isAnimationFinished: Bool
    
    var body: some View {
        LottieView(animation: .named("WinAnimation.json"))
            .playbackMode(.playing(.toProgress(1, loopMode: .playOnce)))
            .animationDidFinish { completed in
                if completed {
                    isAnimationFinished = true  
                }
            }
            .animationSpeed(0.8)
    }
}
