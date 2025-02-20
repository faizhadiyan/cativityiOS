//
//  SettingScreen.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftUI
import SwiftData

struct SettingScreen: View {
    @State var isClassActive = false
    @State var isSleepActive = false
    @State var isLocationActive = false
    @State var isReset = false
    @Environment(\.modelContext) private var context
    @Query private var mainModels: [ActivityDay]
    
    @Query private var schoolLocation: [SchoolModel]
    @Query private var homeLocation: [HomeModel]
    
    var body: some View {
        NavigationStack{
            HStack (alignment: .top) {
                
                Text("Cat Setting")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
            }
            VStack {
                CatLottieView(catType: .constant(.setting))
                    .frame(height: 250)
                    .padding()
                
                Text("Mau sesuaikan pengaturan apa?")
                    .fontDesign(.rounded)
                    .font(.title2)
                    .foregroundStyle(.neutralDarker)
                    .padding()
                
                ListButtonNavigation(text: "Jam Kuliah", imageName: "chevron.right", destination: AnyView(ClassSettingScreen())) {
                    //
                    isClassActive = true
                }
                
                ListButtonNavigation(text: "Jam Tidur", imageName: "chevron.right", destination: AnyView(SleepSettingScreen())) {
                    //
                    isSleepActive = true
                }
                
                ListButtonNavigation(text: "Lokasi", imageName: "chevron.right", destination: AnyView(LocationSettingScreen()), action: {
                    isLocationActive.toggle()
                })
                
                Button("Reset Data") {
                    deleteAllData()
                    clearAppState()
//                    navigateToInitialView()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 25)
                .tint(.red)
            }

            Spacer()
        }
    }
    
    private func deleteAllData() {
        for activityDay in mainModels {
            context.delete(activityDay)
        }
        
        for school in schoolLocation {
            context.delete(school)
        }
        
        for home in homeLocation {
            context.delete(home)
        }
        
        try? context.save()
    }
    
    
    func clearAppState() {
        UserDefaults.standard.setValue(false, forKey: "isNotFirstOpen")
        
        
        // Clear user defaults
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        UserDefaults.standard.synchronize()

        // Clear any other state data if needed
    }

//    func navigateToInitialView() {
//        guard let window = UIApplication.shared.windows.first else {
//            return
//        }
//        let initialView = SleepSettingScreen() // Replace with your initial view
//        window.rootViewController = UIHostingController(rootView: initialView)
//        window.makeKeyAndVisible()
//    }
}

#Preview {
    SettingScreen()
}
