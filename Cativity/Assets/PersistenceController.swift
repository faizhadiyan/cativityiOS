//
//  PersistenceController.swift
//  Cativity
//
//  Created by Wahyu Untoro on 19/05/24.
//

import Foundation
import SwiftData

class PersistenceController {
    static let shared = PersistenceController()

    let container: ModelContainer

    init() {
        container = try! ModelContainer(for: HomeModel.self, SchoolModel.self, LocationModel.self)
    }
}
