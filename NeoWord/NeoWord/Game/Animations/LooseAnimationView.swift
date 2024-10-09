//
//  LooseAnimationView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 09/10/24.
//
import SwiftUI
import Lottie

struct LooseAnimationView: View {
    
    var body: some View {
        LottieView(animation: .named("LooseAnimation.json"))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))

    }
}
