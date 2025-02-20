//
//  ItemListCativity.swift
//  Cativity
//
//  Created by Faiz Hadiyan Firza on 15/05/24.
//

import SwiftUI


struct ItemListCativity: View {
    @Binding var cativityData: Activity
    var isDone: Bool
    var isConflict: Bool
    
    var body: some View {
        HStack {
            CatLottieView(catType: .constant(cativityData.getCatType()))
                .frame(width: 100, height: 100).opacity(isDone ? 0.25 : 1)
            let isItMoreThankNine = cativityData.time > 9
            VStack(alignment: .leading) {
                Text("\(isItMoreThankNine ? "\(cativityData.time)" : "0\(cativityData.time)"):00")
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundStyle(isConflict ? .secondaryDarker : .accent)
                Text(cativityData.type.rawValue)
                    .fontDesign(.rounded)
                    .foregroundStyle(.secondary)
            }
            .opacity(isDone ? 0.25 : 1)
            
            Spacer()
            
            Image(systemName: isConflict ? "exclamationmark.triangle.fill" : "checkmark.square.fill" ).foregroundColor(isConflict ? .secondaryDarker : .accent).opacity(isConflict && !isDone || !isConflict && isDone ? 1 : 0)
        }
    }
    
    func formatDateToHours(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateFormat = "HH:mm" // 24-hour format
        return formatter.string(from: date)
    }
}

#Preview {
    ItemListCativity(cativityData: .constant(Activity(type: .sleep, time: 21, status: .notStart)), isDone: false, isConflict: false)
}

