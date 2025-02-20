//
//  ButtonDanger.swift
//  Cativity
//
//  Created by Gian Pratama on 19/05/24.
//

import SwiftUI

struct ButtonDanger: View {
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
        })
        .buttonStyle(.borderedProminent)
        .tint(.secondaryDarker)
        .controlSize(controlSize)
        .navigationDestination(isPresented: $isActive) {
            destination
        }
    }
}

#Preview {
    ButtonDanger(label:"Atur Ulang")
}
