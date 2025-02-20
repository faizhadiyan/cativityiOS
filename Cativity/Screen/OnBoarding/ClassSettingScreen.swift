//
//  ClassSettingScreen.swift
//  Cativity
//
//  Created by Faiz Hadiyan Firza on 15/05/24.
//

import SwiftUI
import SwiftData

struct ClassSettingScreen: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        @StateObject private var navigationManager = NavigationManager()
    
    @Environment(\.modelContext) private var context
    @State private var selectedDay: Day = .monday
    let days: [Day] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    @State private var selectedIndices: [String: [Int]] = [:]
    let listOfRepeats = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]
    @State var isActive = false
    @Query private var mainModels: [ActivityDay]

    var body: some View {
        NavigationStack {
            VStack {
                CatLottieView(catType: .constant(.book))
                    .frame(height: 150)
                    .scaleEffect(x: 2.5, y: 2.5)
                    .offset(x: -40, y: -30)

                Text("Masukkan jam awal kuliahmu...")
                    .font(.system(.title2, design: .rounded))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)

                SimpleSegmentedPicker(
                    selection: $selectedDay,
                    items: days,
                    selectionColor: .accentDarker
                )

                List {
                    ForEach(listOfRepeats.indices, id: \.self) { index in
                        HStack {
                            Text(formatIntToHours(time: listOfRepeats[index]))
                            Spacer()
                            if let selectedIndicesForDay = selectedIndices[selectedDay.rawValue], selectedIndicesForDay.contains(index) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleSelection(for: index)
                        }
                    }
                }

                Spacer()

                Group {
                    let isDataEmpty = selectedIndices.contains(where: { !$0.value.isEmpty })

                    Button(action: {
                        processSelectedTimes()
                        try? context.save() // Save context after adding activities
                        isActive = true
                    }, label: {
                        Text("Lanjutkan")
                            .frame(width: 150)
                            .fontWeight(.semibold)
                    })
                    .disabled(!isDataEmpty)
                    .buttonStyle(.borderedProminent)
                    .tint(.accentDarker)
                    .controlSize(.extraLarge)
                    .navigationDestination(isPresented: $isActive) {
                        LocationSettingScreen()
                            .environmentObject(navigationManager)
                            .onAppear {
                                delegate.navigationManager = navigationManager
                            }
                    }
                }
            }
        }
    }

    func toggleSelection(for index: Int) {
        if selectedIndices[selectedDay.rawValue]?.contains(index) ?? false {
            selectedIndices[selectedDay.rawValue]?.removeAll { $0 == index }
        } else {
            selectedIndices[selectedDay.rawValue, default: []].append(index)
        }
    }

    func processSelectedTimes() {
        for (key, selectedTimes) in selectedIndices {
            guard let day = Day(rawValue: key) else { continue }
            if let activityDay = mainModels.first(where: { $0.theDay == day }) {
                for index in selectedTimes {
                    addStudyActivity(to: activityDay, time: listOfRepeats[index])
                }
            } else {
                // Create new ActivityDay if not existing
                let newActivityDay = ActivityDay(id: UUID().uuidString, theDay: day)
                for index in selectedTimes {
                    addStudyActivity(to: newActivityDay, time: listOfRepeats[index])
                }
                context.insert(newActivityDay)
            }
        }
    }

    func addStudyActivity(to activityDay: ActivityDay, time: Int) {
        if let studyActivityString = Activity(type: .study, time: time, status: .notStart).toJSONString() {
            activityDay.theActivities.append(studyActivityString)
        }
    }

    func formatIntToHours(time: Int) -> String {
        let hours = time
        let minutes = 0
        return String(format: "%02d:%02d", hours, minutes)
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct DisabledGrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.gray.opacity(0.5)) // Adjust opacity or color as needed
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


#Preview {
    ClassSettingScreen()
}
