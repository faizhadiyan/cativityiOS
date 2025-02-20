//
//  SleepSettingController.swift
//  Cativity
//
//  Created by Wahyu Untoro on 22/05/24.
//

import Foundation


func setSleepTimes(botLimit:Int, upLimit:Int) -> [String] {
    var sleepTimes:[String] = []
    for time in botLimit ... upLimit {
        sleepTimes.append(String(time)+":00")
    }
    return sleepTimes
}

func setSleepDurations(botLimit:Int, upLimit:Int) -> [Int] {
    var sleepDurations:[Int] = []
    for duration in botLimit ... upLimit {
        sleepDurations.append(duration)
    }
    return sleepDurations
}

func getWakeUpTime(sleepTime:String, sleepDuration:Int) -> String {
    let hour:Int = Int(sleepTime.prefix(2)) ?? 20
    var wakeUpTime = hour + sleepDuration
    if wakeUpTime == 24 {
        return "00:00"
    }
    if wakeUpTime > 24 {
        wakeUpTime = wakeUpTime - 24
        return "0" + String(wakeUpTime) + ":00"
    }
    return String(wakeUpTime) + ":00"
}

func getHour(from timeString: String) -> Int? {
    let components = timeString.split(separator: ":")
    if let hourString = components.first, let hour = Int(hourString) {
        return hour
    }
    return nil
}
