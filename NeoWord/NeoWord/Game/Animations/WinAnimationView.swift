//
//  WinAnimationView.swift
//  NeoWord
//
//  Created by lizbeth.alejandro on 09/10/24.
//
import SwiftUI
import Lottie

struct WinAnimationView: View {
  
    var body: some View {
        LottieView(animation: .named("WinAnimation.json"))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))

    }
}
