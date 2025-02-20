//
//  ListButton.swift
//  Cativity
//
//  Created by Farrel Ardra Muhammad on 16/05/24.
//

import SwiftUI

struct ListButton: View {
    var text: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
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
    }
}

#Preview {
    ListButton(text: "Your Text", imageName: "your.image.name", action: {
        // Your action code here
    })
}
