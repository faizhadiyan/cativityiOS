//
//  ActivityModel.swift
//  Cativity
//
//  Created by Yusup Hidayat Winata on 20/05/24.
//

import SwiftUI
import SwiftData

enum ActivityType: String, CaseIterable, Codable {
    case wakeUp = "Bangun"
    case study = "Kuliah"
    case sleep = "Tidur"
}

enum ActivityStatus: String, CaseIterable, Codable {
    case notStart = "Belum Dimulai"
    case early = "Lebih Awal"
    case onTime = "Tepat Waktu"
    case late = "Terlambat"
    case notRecorded = "Tidak Tercatat"
}

struct Activity: Identifiable, Codable {
    var id: String = UUID().uuidString
    var type: ActivityType
    var time: Int
    var status: ActivityStatus
}

extension Activity {
    func getCatType() -> CatType {
        switch self.type {
        case .sleep : return .sleep
        case .study : return .book
        default : return .wakeup
        }
    }
    
    func toJSONString() -> String? {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(self) {
            return String(data: jsonData, encoding: .utf8)
        }
        return nil
    }

    static func fromJSONString(_ jsonString: String) -> Activity? {
        let decoder = JSONDecoder()
        if let jsonData = jsonString.data(using: .utf8) {
            return try? decoder.decode(Activity.self, from: jsonData)
        }
        return nil
    }
}
