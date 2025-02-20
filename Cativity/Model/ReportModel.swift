//
//  ReportModel.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation


class ReportModel {
    let sleepReport: ReportItem
    let wakeReport: ReportItem
    let classReport: ReportItem
    
    init(sleepReport: ReportItem, wakeReport: ReportItem, classReport: ReportItem) {
        self.sleepReport = sleepReport
        self.wakeReport = wakeReport
        self.classReport = classReport
    }
}

class ReportItem {
    let percentage: Double
    let total: Int
    let earlyTimeTotal: Int
    let onTimeTotal: Int
    let lateTimeTotal: Int
    let otherTotal: Int
    
    init(percentage: Double, total: Int, earlyTimeTotal: Int, onTimeTotal: Int, lateTimeTotal: Int, otherTotal: Int) {
        self.percentage = percentage
        self.total = total
        self.earlyTimeTotal = earlyTimeTotal
        self.onTimeTotal = onTimeTotal
        self.lateTimeTotal = lateTimeTotal
        self.otherTotal = otherTotal
    }
}
