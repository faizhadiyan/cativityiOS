//
//  LocationModel.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftData

enum LocationType: Codable {
    case campus
    case home
}

@Model
class SchoolModel: Identifiable {
    var id: String
    @Relationship(deleteRule: .cascade, inverse: \LocationModel.school) var item: LocationModel?
    
    init() {
        self.id = UUID().uuidString
    }
}

@Model
class HomeModel: Identifiable {
    var id: String
    @Relationship(deleteRule: .cascade, inverse: \LocationModel.home) var item: LocationModel?
    
    init() {
        self.id = UUID().uuidString
    }
}

@Model
class LocationModel: Identifiable {
    var id: String
    var type: LocationType
    var latitude: Double
    var longitude: Double
    var home: HomeModel?
    var school: SchoolModel?
    
    init(type: LocationType, latitude: Double, longitude: Double) {
        self.id = UUID().uuidString
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
    }
}
