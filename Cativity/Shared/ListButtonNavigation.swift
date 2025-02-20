//
//  ListButtonNavigation.swift
//  Cativity
//
//  Created by Farrel Ardra Muhammad on 16/05/24.
//

import SwiftUI

struct ListButtonNavigation: View {
    @State var isActive: Bool = false
    
    var text: String
    var imageName: String
    var destination: AnyView
    var action: (() -> Void)?
    
    var body: some View {
        
        Button(action: {action?()
            isActive.toggle()}) {
            HStack {
                Text(text)
                
                Spacer()
                
                Image(systemName: imageName)
            }
            .padding()
            .background(Color.neutralLighter)
            .foregroundColor(.black)
            .cornerRadius(8)
        }
        .padding([.leading, .trailing])
        .navigationDestination(isPresented: $isActive) {
            destination
        }
        
    }
}

#Preview {
    ListButtonNavigation(text: "hehehe", imageName: "a", destination: AnyView(SleepSettingScreen())) {
        //
    }
}
