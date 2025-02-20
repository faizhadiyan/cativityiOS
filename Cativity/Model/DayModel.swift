//
//  DayModel.swift
//  Cativity
//
//  Created by Yusup Hidayat Winata on 20/05/24.
//

import SwiftUI
import SwiftData

enum Day: String, Hashable, Codable, CaseIterable {
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"
    case sunday = "Sun"
    
    init?(abbreviation: String) {
        switch abbreviation.lowercased() {
        case "mon":
            self = .monday
        case "tue":
            self = .tuesday
        case "wed":
            self = .wednesday
        case "thu":
            self = .thursday
        case "fri":
            self = .friday
        case "sat":
            self = .saturday
        case "sun":
            self = .sunday
        default:
            return nil
        }
    }
    
    func setDayInIndonesia() -> String {
        switch self {
        case .monday:
            return "Sen"
        case .tuesday:
            return "Sel"
        case .wednesday:
            return "Rab"
        case .thursday:
            return "Kam"
        case .friday:
            return "Jum"
        case .saturday:
            return "Sab"
        default:
            return "Min"
        }
    }
    
    func toIndex() -> Int {
        switch self {
        case .monday:
            return 0
        case .tuesday:
            return 1
        case .wednesday:
            return 2
        case .thursday:
            return 3
        case .friday:
            return 4
        case .saturday:
            return 5
        default:
            return 6
        }
    }
    
    func toLocalizedString() -> String {
        switch self {
        case .monday:
            return "hari senin"
        case .tuesday:
            return "hari selasa"
        case .wednesday:
            return "hari rabu"
        case .thursday:
            return "hari kamis"
        case .friday:
            return "hari jumat"
        case .saturday:
            return "hari sabtu"
        default:
            return "hari minggu"
        }
    }
    
    static func fromIndex(_ index: Int) -> Day? {
        guard index >= 0 && index < Day.allCases.count else {
            return nil
        }
        return Day.allCases[index]
    }
    
    static func < (lhs: Day, rhs: Day) -> Bool {
        return lhs.toIndex() < rhs.toIndex()
        }
}


@Model
class ActivityDay: Identifiable {
    var id: String
    var theDay: Day
    var theActivities: [String]

    init(id: String, theDay: Day, theActivities: [String] = []) {
        self.id = id
        self.theDay = theDay
        self.theActivities = theActivities
    }
}

func initializeDays() -> [ActivityDay] {
    let days = (0...6).compactMap { Day.fromIndex($0) }
    return days.map { ActivityDay(id: UUID().uuidString, theDay: $0) }
}

func addActivity(to day: Day, activity: Activity, in days: inout [ActivityDay]) {
    if let index = days.firstIndex(where: { $0.theDay == day }) {
        if let activityString = activity.toJSONString() {
            days[index].theActivities.append(activityString)
        }
    }
}

func getActivities(for day: Day, from days: [ActivityDay]) -> [Activity] {
    if let dayData = days.first(where: { $0.theDay == day }) {
        return dayData.theActivities.compactMap { Activity.fromJSONString($0) }
    }
    return []
}
