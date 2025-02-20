//
//  ImageRenderer.swift
//  Cativity
//
//  Created by Wahyu Untoro on 20/05/24.
//

import Foundation
import SwiftUI

struct ImageRenderer<Content: View> {
    let content: Content
    
    var uiImage: UIImage? {
        let controller = UIHostingController(rootView: content)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        // Force layout
        view?.layoutIfNeeded()
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}
