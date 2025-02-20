//
//  ButtonSecondary.swift
//  Cativity
//
//  Created by Gian Pratama on 18/05/24.
//

import SwiftUI

struct ButtonSecondary: View {
    @State var isActive: Bool = false
    
    var maxWidth: CGFloat = 0
    var minWidth: CGFloat = 150
    var label: String
    var destination: AnyView?
    var controlSize: ControlSize = .extraLarge
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
            isActive.toggle()
        }, label: {
            Text(label)
                .frame(idealWidth: minWidth, maxWidth: maxWidth)
                .fontWeight(.semibold)
                .foregroundColor(.accentDarker)
        })
        .buttonStyle(.borderedProminent)
        .tint(Color.accentDarker.tertiary)
        .controlSize(controlSize)
        .navigationDestination(isPresented: $isActive) {
            destination
        }
    }
}
