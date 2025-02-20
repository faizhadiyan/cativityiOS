//
//  CatImageView.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftUI

struct CatImageView: View {
    @Binding var catType: CatType // receives a lottieView name
    
    func getCatName(catType: CatType) -> String {
        switch catType {
        case .angry:
            return "cat_angry"
        case .book:
            return "cat_book"
        case .eat:
            return "cat_eat"
        case .happy:
            return "cat_happy"
        case .hungry:
            return "cat_hungry"
        case .play:
            return "cat_play"
        case .sleep:
            return "cat_sleep"
        case .watch:
            return "cat_watch"
        case .location:
            return "cat_location"
        case .setting:
            return "cat_setting"
        case .wakeup:
            return "cat_wakeup"
        default:
            return "cat_idle"
        }
    }
    
    var body: some View {
        Image(getCatName(catType: catType))
    }
}

#Preview {
    CatImageView(catType: .constant(.angry))
}
