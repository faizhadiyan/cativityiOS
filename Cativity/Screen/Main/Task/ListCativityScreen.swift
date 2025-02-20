//
//  ListCativity.swift
//  Cativity
//
//  Created by Faiz Hadiyan Firza on 15/05/24.
//

import SwiftUI
import SwiftData

struct ListCativityScreen: View {
    
    @Query private var mainModels: [ActivityDay]
    
    let days = [Day.monday, Day.tuesday, Day.wednesday, Day.thursday, Day.friday, Day.saturday, Day.sunday]
    var isConflict: Bool = false
    
    @State private var selectedDay = Day.monday
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    Text("Cativity")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                }
                
                SimpleSegmentedPicker(
                    selection: $selectedDay,
                    items: days,
                    selectionColor: .accentDarker
                )
                
                List {
                    ForEach(mainModels) { day in
                        if (day.theDay == selectedDay) {
                           
                                ForEach(getSortedActivities(for: day)) { activity in
                                    ItemListCativity(cativityData: .constant(activity), isDone: false, isConflict: false)
                                }
                            
                        }
                    }
                }
                
                Spacer()
                
                if isConflict {
                    ButtonDanger(label: "Atur Ulang")
                        .padding()
                }
            }
        }
    }
    
    func getSortedActivities(for day: ActivityDay) -> [Activity] {
        return day.theActivities.compactMap { Activity.fromJSONString($0) }.sorted { $0.time < $1.time }
    }
}

#Preview {
    ListCativityScreen()
}

