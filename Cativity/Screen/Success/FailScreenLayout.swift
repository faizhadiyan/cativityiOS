//
//  FailScreenLayout.swift
//  Cativity
//
//  Created by Yusup Hidayat Winata on 16/05/24.
//

import SwiftUI

struct FailScreenLayout: View {
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                
                Text("Hmmm...\nSepertinya saat ini kamu\n lagi gak di kampus...")
                    .font(.title2)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.neutralDarker)
                
                ButtonDanger(label: "↻ Refresh lokasi", controlSize: .small)
                    .padding()
            }
            
            Spacer()
            Spacer()
            
            CatLottieView(catType: .constant(.watch))
                .scaleEffect(CGSize(width: 2, height: 2))
                .frame(height: 350)
                .offset(x: 90, y: -20)
            
            Spacer()
            
            VStack {
                Text("Jadi bagaimana kuliahmu?")
                    .font(.title3.weight(.semibold))
                    .fontDesign(.rounded)
                    .foregroundStyle(.neutralDarker)
                    .padding(.bottom)
                
                HStack {
                    ButtonSecondary(label: "Sedang Libur")
                    ButtonPrimary(label: "Kuliah Online")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    FailScreenLayout()
}
