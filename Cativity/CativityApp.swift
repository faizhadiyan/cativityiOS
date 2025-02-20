//
//  CativityApp.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import SwiftUI
import SwiftData
import UserNotifications

class NavigationManager: ObservableObject {
    @Published var navigateToPage: String?
}

@main
struct CativityApp: App {
    let modelContainer: ModelContainer
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        @StateObject private var navigationManager = NavigationManager()
    
    init() {
        do {
            //                print(URL.applicationSupportDirectory.path(percentEncoded: false))
            modelContainer = try ModelContainer(for: HomeModel.self, SchoolModel.self, LocationModel.self, ActivityDay.self, WeekModel.self)
        } catch {
            print("ModelContainer initialization failed with error: \(error)")
            fatalError("Could not initialize ModelContainer: \(error)")
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            let isNotFirstOpen = UserDefaults.standard.bool(forKey: "isNotFirstOpen")
            
            if (!isNotFirstOpen) {
                SleepSettingScreen()
                    .edgesIgnoringSafeArea(.all)
                    .environmentObject(navigationManager)
                    .onAppear {
                        delegate.navigationManager = navigationManager
                    }
            } else {
                MainView()
                    .environmentObject(navigationManager)
                    .onAppear {
                        delegate.navigationManager = navigationManager
                    }
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .modelContainer(modelContainer)
        
    }
}
