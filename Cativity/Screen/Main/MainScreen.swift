//
//  MainScreen.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftUI
import UserNotifications

struct MainView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        NavigationStack {
            ZStack {

                NavigationLink(destination: SuccessScreenLayout(), tag: "PageToNavigate", selection: $navigationManager.navigateToPage) {
                                    EmptyView()
                                }
                
                Color.white.ignoresSafeArea()
                
                TabView {
                    ListCativityScreen()
                        .tabItem {
                            Label("Cativity", systemImage: "list.bullet")
                        }
                    
                    ReportScreen()
                        .tabItem {
                            Label("Capaian", systemImage: "text.book.closed")
                        }
                    
                    SettingScreen()
                        .tabItem {
                            Label("Setting", systemImage: "gear")
                        }
                }
            }
            .onAppear{
                print("onAppear")
//                print("Data \(notificationCenterDelegate.navigateToPage)")
            }
        
        }
        .onAppear(){
            checkNotificationPermission()
            requestNotificationPermission()
            scheduleNotification(date: .now, title: "15 Menit Sebelum Kuliah", body: "Ayo check-in sebelum waktunya untuk dapat reward!")
//            NotificationHelper.scheduleNotification(notificationTimeString: "10:55")
        }
        .onAppear{
            print("data")
//            print($notificationCenterDelegate.navigateToPage)
        }
        .navigationBarBackButtonHidden()
    }
    
}


#Preview {
    MainView()
}
