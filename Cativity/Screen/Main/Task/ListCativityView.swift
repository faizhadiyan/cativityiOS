//
//  ListCativityView.swift
//  Cativity
//
//  Created by Wahyu Untoro on 23/05/24.
//

import Foundation
import SwiftUI

struct ListCativityView: View {
    @Binding var mainModels: [WeekModel]
    @Binding var selectedDay: Day
    
    var body: some View {
        ForEach(Array(mainModels.enumerated()), id: \.element.id) { index, activity in
            if let weekActivities = activity.weekActivities {
                let sortedWeekActivities = weekActivities.sorted {
                    $0.getActivity().time < $1.getActivity().time
                }
                
                ForEach(Array(sortedWeekActivities.enumerated()), id: \.element.id) { index2, weekActivity in
                    if weekActivity.theDay == selectedDay {
                        VStack {
                            let data = weekActivity.getActivity()
                            print("Day: \(weekActivity.theDay), Time: \(data.time), Activity: \(data.type)")
                            ItemListCativity(cativityData: .constant(data), isDone: data.status == .onTime, isConflict: false)
                        }
                    }
                }
            } else {
                Spacer()
                // Handle weekActivities being nil
            }
        }
        
    }
}
