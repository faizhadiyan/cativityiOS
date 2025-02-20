//
//  SleepSettingScreen.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftUI
import SwiftData

struct SleepSettingScreen: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var navigationManager = NavigationManager()
    
    let sleepTimes = setSleepTimes(botLimit: 20, upLimit: 23)
    let sleepDurations = setSleepDurations(botLimit: 5, upLimit: 8)
    
    @State var sleepTime: String = "20:00" // Default Value
    @State var sleepDuration: Int = 8 // Default Value
    @State var wakeUpTime: String = "04:00"
    
    // MARK: Redundant but OK
    @State var sleepTimeInt: Int = 20
    @State var wakeUpTimeInt: Int = 8
    
    @Environment(\.modelContext) private var context
    
    @Query private var mainModels: [ActivityDay]
    @State private var listDay: [ActivityDay] = initializeDays()
    
    @State var nextScreen: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                CatLottieView(catType: .constant(.sleep))
                    .scaleEffect(CGSize(width: 1.5, height: 1.5))
                
                Text("Atur jam tidurmu...")
                    .font(.title2)
                    .padding(.top, 40)
                    .padding(.bottom, 50)
                
                VStack{
                    HStack{
                        Text("Jam Tidur")
                        Spacer()
                        HStack{
                            Menu {
                                ForEach(0 ..< sleepTimes.count, id: \.self) {time in
                                    Button(sleepTimes[time]) {
                                        sleepTime = sleepTimes[time]
                                    }
                                }
                            } label: {
                                Text(sleepTime)
                                    .foregroundStyle(.accentDarker)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding()
                    .background(Color.neutralLighter)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    HStack {
                        Text("Durasi")
                        Spacer()
                        HStack{
                            Menu {
                                ForEach(0 ..< sleepDurations.count, id: \.self) {time in
                                    Button(String(sleepDurations[time])) {
                                        sleepDuration = sleepDurations[time]
                                    }
                                }
                            } label: {
                                Text(String(sleepDuration) + " jam")
                                    .foregroundStyle(.accentDarker)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color.neutralLighter)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .font(.title3)
                .tint(Color.accentDarker.quinary)
                
                Spacer()
                
                
                ButtonPrimary(label: "Lanjut", destination: AnyView(ClassSettingScreen().environmentObject(navigationManager)
                    .onAppear {
                        delegate.navigationManager = navigationManager
                    })) {
                        wakeUpTime = getWakeUpTime(sleepTime: sleepTime, sleepDuration: sleepDuration)
                        
                        sleepTimeInt = Int(sleepTime.prefix(2)) ?? 20
                        wakeUpTimeInt = getHour(from: wakeUpTime) ?? 4
                        
                        print("Sleep time =\(wakeUpTimeInt)")
                        print("Wake up time = \(wakeUpTimeInt) \(wakeUpTime)")
                        
                        replaceDataWithWakeUpAndSleepTimes(wakeUpTimeInt: wakeUpTimeInt, sleepTimeInt: sleepTimeInt)
                        
                        
                        nextScreen = true
                    }
                    .padding()
                    .onAppear(){
                    }
            }.padding()
            
        }
        .fontDesign(.rounded)
        
    }
    
    private func replaceDataWithWakeUpAndSleepTimes(wakeUpTimeInt: Int, sleepTimeInt: Int) {
        
        for dayIndex in 0...6 {
            if let day = Day.fromIndex(dayIndex), let activityDay = mainModels.first(where: { $0.theDay == day }) {
                removeSpecificActivities(from: activityDay, types: [.wakeUp, .sleep])
                var activities = activityDay.theActivities
                
                if let wakeUpActivityString = Activity(type: .wakeUp, time: wakeUpTimeInt, status: .notStart).toJSONString() {
                    activities.append(wakeUpActivityString)
                    addActivityDay(activityDay)
                }
                
                if let sleepActivityString = Activity(type: .sleep, time: sleepTimeInt, status: .notStart).toJSONString() {
                    activities.append(sleepActivityString)
                    addActivityDay(activityDay)
                }
                
                
                activityDay.theActivities = activities
                try? context.save()
            }
        }
    }
    
    private func deleteAllData() {
        for activityDay in mainModels {
            context.delete(activityDay)
        }
        try? context.save()
    }
    
    private func removeSpecificActivities(from activityDay: ActivityDay, types: [ActivityType]) {
        activityDay.theActivities.removeAll { activityString in
            if let activity = Activity.fromJSONString(activityString) {
                return types.contains(activity.type)
            }
            return false
        }
    }
    
    private func addActivityDay(_ activityDay: ActivityDay) {
        context.insert(activityDay)
        try? context.save()
    }
    
    private func getActivities(for day: Day, from days: [ActivityDay]) -> [Activity] {
        if let dayData = days.first(where: { $0.theDay == day }) {
            return dayData.theActivities.compactMap { Activity.fromJSONString($0) }
        }
        return []
    }
}

#Preview {
    SleepSettingScreen()
}
