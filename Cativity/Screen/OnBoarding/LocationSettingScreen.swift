//
//  LocationSettingScreen.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftUI
import MapKit
import SwiftData

struct LocationSettingScreen: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var navigationManager = NavigationManager()
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var schoolLocation: [SchoolModel]
    @Query private var homeLocation: [HomeModel]
    
    @State private var isShowingSheet = false
    @State private var typeLocation = LocationType.home
    
    @State private var selectedHomeLocation: CLLocation?
    @State private var selectedSchoolLocation: CLLocation?
    
    @State private var homeAddress: String = "Rumah"
    @State private var schoolAddress: String = "Kampus"
    
    @State private var showAlert = false
    @State private var isNavigate = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                CatLottieView(catType: .constant(.setting))
                
                Text("Agar aplikasi lebih akurat,\nijinkan akses lokasi dan pilih lokasi\nrumah dan kampusmu")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                ListButton(text: homeAddress, imageName: "location.fill") {
                    typeLocation = .home
                    isShowingSheet = true
                }
                .onAppear {
                    if let homeLocation = selectedHomeLocation {
                        convertClLocationToString(location: homeLocation) { address in
                            self.homeAddress = address
                        }
                    }
                }
                
                ListButton(text: schoolAddress, imageName: "location.fill") {
                    typeLocation = .campus
                    isShowingSheet = true
                }
                .onAppear {
                    if let schoolLocation = selectedSchoolLocation {
                        convertClLocationToString(location: schoolLocation) { address in
                            self.schoolAddress = address
                        }
                    }
                }
                
                Spacer()
                
                ButtonPrimary(label: "Lanjut", destination:  AnyView(
                    WelcomeScreenView()
                        .environmentObject(navigationManager)
                        .onAppear {
                            delegate.navigationManager = navigationManager
                        }
                ), action: {
                    if (self.selectedHomeLocation != nil && self.selectedSchoolLocation != nil) {
                        let isNotFirstOpen = UserDefaults.standard.bool(forKey: "isNotFirstOpen")
                        
                        saveToSwiftData(type: .home, location: CLLocationCoordinate2D(latitude: selectedHomeLocation?.coordinate.latitude ?? 0.0, longitude: selectedHomeLocation?.coordinate.longitude ?? 0.0)
                        )
                        
                        saveToSwiftData(type: .campus, location: CLLocationCoordinate2D(latitude: selectedSchoolLocation?.coordinate.latitude ?? 0.0, longitude: selectedSchoolLocation?.coordinate.longitude ?? 0.0)
                        )
                        
                        if (!isNotFirstOpen) {
                            isNavigate = true
                        } else {
                            dismiss()
                        }
                        print($isNavigate)
                    } else {
                        showAlert = true
                    }
                })
                .padding()
//                .alert(isPresented: $showAlert) {
//                    Alert(
//                        title: Text("Lokasi Belum Dipilih"),
//                        message: Text("Apakah kamu yakin ingin melanjutkan tanpa memilih lokasi ?"),
//                        primaryButton: .destructive(
//                            Text("Lanjutkan"))                 {
//                                let isNotFirstOpen = UserDefaults.standard.bool(forKey: "isNotFirstOpen")
//                                if (selectedHomeLocation) != nil {
//                                    saveToSwiftData(type: .home, location: CLLocationCoordinate2D(latitude: selectedHomeLocation?.coordinate.latitude ?? 0.0, longitude: selectedHomeLocation?.coordinate.longitude ?? 0.0)
//                                    )
//                                }
//                                
//                                if (selectedSchoolLocation != nil) {
//                                    saveToSwiftData(type: .campus, location: CLLocationCoordinate2D(latitude: selectedSchoolLocation?.coordinate.latitude ?? 0.0, longitude: selectedSchoolLocation?.coordinate.longitude ?? 0.0)
//                                    )
//                                    
//                                }
//                                
//                                if (!isNotFirstOpen) {
//                                    isNavigate = true
//                                } else {
//                                    dismiss()
//                                }
//                                print($isNavigate)
//                            },
//                        secondaryButton: .default(
//                            Text("Isi dulu")){
//                                showAlert = false
//                            }
//                    )
//                }
            }
            .sheet(isPresented: $isShowingSheet) {
                BottomSheetMap(onSave: .constant({ selectedLocation, type in
                    if type == .home {
                        self.selectedHomeLocation = selectedLocation
                        convertClLocationToString(location: selectedLocation) { address in
                            self.homeAddress = address
                        }
                    } else {
                        self.selectedSchoolLocation = selectedLocation
                        convertClLocationToString(location: selectedLocation) { address in
                            self.schoolAddress = address
                        }
                    }
                    isShowingSheet = false
                }), onDismiss: .constant({
                    isShowingSheet = false
                }), locationType: $typeLocation)
            }
            .onAppear(){
                if (!schoolLocation.isEmpty) {
                    
                    let dataCoordinate = schoolLocation.first!.item
                    selectedSchoolLocation = CLLocation(latitude: dataCoordinate!.latitude, longitude: dataCoordinate!.longitude)
                }
                
                if (!homeLocation.isEmpty) {
                    
                    let dataCoordinate = homeLocation.first!.item
                    selectedHomeLocation = CLLocation(latitude: dataCoordinate!.latitude, longitude: dataCoordinate!.longitude)
                }
            }
        }
    }
}

extension LocationSettingScreen {
    func convertClLocationToString(location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed with error: \(error.localizedDescription)")
                completion("Unknown location")
                return
            }
            
            if let placemark = placemarks?.first {
                let address = [
                    placemark.subThoroughfare,
                    placemark.thoroughfare,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.postalCode,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
                
                print("sampe sini \(placemark)")
                completion(address)
            } else {
                completion("No address found")
            }
        }
    }
    
    func saveToSwiftData(type: LocationType, location: CLLocationCoordinate2D) {
        let locationItem = LocationModel(type: type, latitude: location.latitude, longitude: location.longitude)
        
        if (type == .campus) {
            let item = schoolLocation.first
            
            if (item != nil) {
                context.delete(item!)
            }
            
            let data = SchoolModel()
            data.item = locationItem
            context.insert(data)
            
            print("data=\(data)}")
        } else {
            let item = homeLocation.first
            
            if (item != nil) {
                context.delete(item!)
            }
            
            let data = HomeModel()
            data.item = locationItem
            context.insert(data)
            
            print("data2=\(data)}")
        }
    }
}


#Preview {
    LocationSettingScreen()
}
