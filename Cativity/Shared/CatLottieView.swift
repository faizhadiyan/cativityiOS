//
//  CustomLottieView.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import Foundation
import SwiftUI
import Lottie

struct CatLottieView: View {
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
        case .setting:
            return "cat_settings"
        default:
            return "cat_idle"
        }
    }
    
    var body: some View {
        LottieView(animation: .named(getCatName(catType: catType)))
          .playing()
          .looping()
    }
}
