//
//  StackedBarView.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import SwiftUI

struct StackedBarView: View {
    @State var rectangleWidht: Double = 65
    @State var rectangleHeight: Double = 30
    
    let randomInt1 = Int.random(in: 1...9)
    let randomInt2 = Int.random(in: 40...100)
    let randomInt3 = Int.random(in: 10...20)
    let randomInt4 = Int.random(in: 1...80)
    
    
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    Text("\(randomInt1)")
                        .foregroundStyle(Color.black)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .frame(width: 20, height: rectangleHeight)
                        .background(Color.secondaryLighter)
                }
                .padding(.trailing, -10)
                
                ZStack {
                    Text("\(randomInt2)")
                        .foregroundStyle(Color.black)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .frame(width: 100, height: rectangleHeight)
                        .background(Color.secondaryNormal)
                }
                .padding(.trailing, -10)
                
                ZStack {
                    Text("\(randomInt3)")
                        .foregroundStyle(Color.black)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .frame(width: 30, height: rectangleHeight)
                        .background(Color.secondaryDarker)
                }
                
                
            }
            .cornerRadius(29)
            
            ZStack {
                Circle()
                    .frame(width: 30)
                    .foregroundStyle(.gray)
                
                Text("\(randomInt4)")
                    .foregroundStyle(Color.black)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
            }
            
        }
    }
}

#Preview {
    StackedBarView()
}
