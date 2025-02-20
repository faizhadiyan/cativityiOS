//
//  ButtonPrimary.swift
//  Cativity
//
//  Created by Gian Pratama on 18/05/24.
//

import SwiftUI

struct ButtonPrimary: View {
    @State var isActive: Bool = false
    
    var maxWidth: CGFloat = 0
    var minWidth: CGFloat = 150
    var label: String
    var destination: AnyView?
    var controlSize: ControlSize = .extraLarge
    var action: (() -> Void)?
    
    var body: some View {
        NavigationStack {
            Button(action: {
                action?()
                isActive.toggle()
                print("next \(isActive)")
            }, label: {
                Text(label)
                    .frame(idealWidth: minWidth, maxWidth: maxWidth)
                    .fontWeight(.semibold)
            })
            .buttonStyle(.borderedProminent)
            .tint(.accentDarker)
            .controlSize(controlSize)
            .navigationDestination(isPresented: $isActive) {
                destination
            }
        }
    }
}
