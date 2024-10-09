//
//  LooseAnimationView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 09/10/24.
//
import SwiftUI
import Lottie

struct LooseAnimationView: View {
    @Binding var isLooseAnimationFinished: Bool
    
    var body: some View {
        LottieView(animation: .named("LooseAnimation.json"))
            .playbackMode(.playing(.toProgress(1, loopMode: .playOnce)))
            .animationDidFinish { completed in
                if completed {
                    isLooseAnimationFinished = true
                }
            }
            .animationSpeed(0.8)
    }
}
