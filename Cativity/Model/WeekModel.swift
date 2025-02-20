//
//  WeekModel.swift
//  Cativity
//
//  Created by Yusup Hidayat Winata on 20/05/24.
//

import SwiftUI
import SwiftData

@Model
class WeekModel: Identifiable {
    var id: String
    
//    @Relationship(deleteRule: .cascade, inverse: \ActivityDay.weekss) var weekActivities: [ActivityDay]? = []
    
    // MARK: fungsi init dipanggil saat membuat instance dari WeekModel.
    init(weekActivities: [ActivityDay]?){
        self.id = UUID().uuidString
//        self.weekActivities = weekActivities ?? []
    }
    
//    func sortedWeekActivities() -> [ActivityDay] {
//            return weekActivities?.sorted {
//                $0.theDay < $1.theDay
//            } ?? []
//        }
}
