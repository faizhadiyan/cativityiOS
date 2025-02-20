//
//  SuccessScreenLayout.swift
//  Cativity
//
//  Created by Yusup Hidayat Winata on 16/05/24.
//

import SwiftUI

struct SuccessScreenLayout: View {
    
    let wakeUpStreakViewModel = WakeUpStreakViewModel()
    let classStreakViewModel = ClassStreakViewModel()
    let sleepStreakViewModel = SleepStreakViewModel()
    
    @Environment(\.dismiss) private var dismiss

    let activityStatus: [String: String] = [
        "early": "Wow! Kamu kuliah\n lebih awal 🔥",
        "onTime": "Yeah! Kamu kuliah\n tepat waktu 🎯",
        "late": "Ouch, Kamu terlambat\n 10 menit",
    ]
    
    let message: [String: String] = [
        "early": "Kamu berhasil menjaga waktu!",
        "onTime": "Kamu berhasil menjaga waktu!",
        "late": "Lain kali kamu bisa lebih baik...",
    ]
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                
                Text("\(activityStatus["early"] ?? "")")
                    .font(.title.weight(.bold))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.accentDarker)
                
                
                Text("\(message["early"] ?? "")")
                    .font(.title2)
                    .fontDesign(.rounded)
                    .foregroundStyle(.neutralDarker)
                    .padding()
            }
            
            Spacer()
            Spacer()
            
            CatLottieView(catType: .constant(.book))
                .scaleEffect(CGSize(width: 3.5, height: 3.5))
                .frame(height: 350)
                .offset(x:-75, y:-150)
            
            Spacer()
            
            ButtonPrimary(label: "OK, Thanks!", destination: AnyView(ReportScreen()), action: {
                classStreakViewModel.incrementStreak()
                dismiss()
            })
            
//            ButtonSecondary(label: "Dummy Reset", destination: AnyView(ReportScreen()), action: {
//                classStreakViewModel.resetStreak()
//            })
//                .padding()

            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
    
    /*func dispMainMsg(mainMsg:String, lateDuration:Int=0) {
     if lateDuration != 0 {
     self.mainMsg = "Hari ini kamu terlambat kuliah \(lateDuration)"
     }
     }*/
}

#Preview {
    SuccessScreenLayout()
}
