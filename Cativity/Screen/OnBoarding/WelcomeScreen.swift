//
//  WelcomeScreen.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import SwiftUI

struct WelcomeScreenView: View {
    @State var isActive = false
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                ZStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Selamat!")
                            .font(.custom("VeryLarge", size: 40))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundStyle(.accent)
                        Text("Kamu sudah atur\njadwal aktivitasmu.\nAyo selesaikan bersama, satu persatu, tanpa telat..")
                            .fontDesign(.rounded)
                    }
                    .offset(x: -70, y: 30)
                    .frame(width: 200)
                    CatLottieView(catType: .constant(.watch))
                        .offset(x: 135)
                }
                .frame(width: 400)
                .padding(.top, 200)
                
                Image("cat_paws")
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.5)
                
                ZStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Konsisten waktu")
                            .font(.custom("VeryLarge", size: 40))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundStyle(.accent)
                        Text("adalah hal yang penting bagi seorang mahasiswa. Mulailah teratur dari sekadar jadwal tidur...")
                            .fontDesign(.rounded)
                    }
                    .offset(x: 80, y: -15)
                    .frame(width: 200)
                    CatLottieView(catType: .constant(.sleep)).scaleEffect(x: -1)
                        .offset(x:-140)
                }
                
                Image("cat_paws")
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(x: -1)
                    .opacity(0.5)
                
                VStack {
                    CatLottieView(catType: .constant(.happy))
                    Text("Siap.. Sedia..")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(.accent)

                    ButtonPrimary(label: "Mulai!", destination: AnyView(
                        MainView()
                            .environmentObject(navigationManager)
                            .onAppear {
                                delegate.navigationManager = navigationManager
                            }
                    )) {
                        UserDefaults.standard.setValue(true, forKey: "isNotFirstOpen")

                        isActive.toggle()
                    }

                }
                .padding(.bottom, 64)
            })
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    WelcomeScreenView()
}

