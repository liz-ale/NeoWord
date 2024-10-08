//
//  CustomDialog.swift
//  NeoWord
//
//  Created by julian.garcia on 08/10/24.
//

import SwiftUI

struct CustomDialog: View {
    
    @Binding var isActive: Bool
    
    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> Void
    
    @State private var offset: CGFloat = 1000
    
    @State private var backgroundOpacity: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(backgroundOpacity)
                .ignoresSafeArea()
            
            VStack {
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()
                
                Text(message)
                    .font(.body)
                
                Button {
                    action()
                    close()
                } label: {
                    Text(buttonTitle)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.cyan)
                            
                        }
                        .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(minWidth: 200, maxWidth: 500)
            .padding()
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding()
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    backgroundOpacity = 0.6
                    offset = 0
                }
            }
        }
    }
    
    func close() {
        withAnimation(.spring()) {
            backgroundOpacity = 0.0
            offset = 1000
            isActive = false
        }
    }
}

#Preview {
    CustomDialog(
        isActive: .constant(true),
        title: "Felicidades",
        message: "+100 puntos",
        buttonTitle: "Continuar",
        action: {
        }
    )
}
