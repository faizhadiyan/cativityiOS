//
//  StreakModel.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftUI

// Model untuk menyimpan streak aktivitas tidur
struct SleepStreak: Codable {
    var days: Int
}

struct ClassStreak: Codable {
    var days: Int
}

struct WakeUpStreak: Codable {
    var days: Int
}

// Wrapper untuk mengelola UserDefaults
@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            // Membaca nilai dari UserDefaults
            guard let data = UserDefaults.standard.data(forKey: key),
                  let value = try? JSONDecoder().decode(T.self, from: data)
            else {
                // Mengembalikan nilai default jika tidak ada data di UserDefaults
                return defaultValue
            }
            return value
        }
        set {
            // Menyimpan nilai ke UserDefaults
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}

class SleepStreakViewModel: ObservableObject {
    
    // Menggunakan UserDefault untuk menyimpan streak
    @UserDefault(key: "sleepStreak", defaultValue: SleepStreak(days: 0))
    var sleepStreak: SleepStreak
    
    // Fungsi untuk menambahkan streak
    func incrementStreak() {
        sleepStreak.days += 1
    }
    
    // Fungsi untuk mereset streak
    func resetStreak() {
        sleepStreak.days = 0
    }
}

class ClassStreakViewModel: ObservableObject {
    
    // Menggunakan UserDefault untuk menyimpan streak
    @UserDefault(key: "classStreak", defaultValue: ClassStreak(days: 0))
    var classStreak: ClassStreak
    
    // Fungsi untuk menambahkan streak
    func incrementStreak() {
        classStreak.days += 1
    }
    
    // Fungsi untuk mereset streak
    func resetStreak() {
        classStreak.days = 0
    }
}

class WakeUpStreakViewModel: ObservableObject {
    
    // Menggunakan UserDefault untuk menyimpan streak
    @UserDefault(key: "wakeUpStreak", defaultValue: WakeUpStreak(days: 0))
    var wakeUpStreak: WakeUpStreak
    
    // Fungsi untuk menambahkan streak
    func incrementStreak() {
        wakeUpStreak.days += 1
    }
    
    // Fungsi untuk mereset streak
    func resetStreak() {
        wakeUpStreak.days = 0
    }
}
