//
//  StreakView.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftUI

struct StreakView: View {
    
    @State var streakName: Array<String> = ["Bangun", "Kuliah", "Tidur"]
    @State var streakCount: Int = 0
    
    let wakeUpStreakViewModel = WakeUpStreakViewModel()
    let classStreakViewModel = ClassStreakViewModel()
    let sleepStreakViewModel = SleepStreakViewModel()
    
    struct StreakItem: View {
        
        let streakName: String
        let streakCount: Int
        let streakImage: CatImageView
        
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 120, height: 120)
                    .background(.white)
                    .cornerRadius(10)
                    .offset(x: 0, y: 0)
                
                Text(streakName)
                    .font(.body)
                    .fontWeight(.regular)
                    .fontDesign(.rounded)
                    .foregroundStyle(.accent)
                    .offset(x: 0, y: -42.50)
                
                Text("\(streakCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.accent)
                    .offset(x: 0, y: -15)
                streakImage
                    .scaleEffect(x:0.375, y: 0.375)
                    .offset(y: 20)
                    .frame(height: 100)
            }
            .frame(width: 120, height: 120)
        }
    }
    
    var body: some View {
        
        HStack {
            Spacer()
            VStack {
                Text("Semua Runtutan Tepat Waktu")
                    .font(.headline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                
                ZStack {
                    HStack {
                        StreakItem(streakName: "\(streakName[0])", streakCount: 20, streakImage: CatImageView(catType: .constant(.wakeup)))
                        StreakItem(streakName: "\(streakName[1])", streakCount: 6, streakImage: CatImageView(catType: .constant(.book)))
                        StreakItem(streakName: "\(streakName[2])", streakCount: 20, streakImage: CatImageView(catType: .constant(.sleep)))
                    }
                }
            }
            .padding()
            .frame(maxHeight: 200)
            Spacer()
        }
        .background(.accent)
    }
}

#Preview {
    StreakView()
}
