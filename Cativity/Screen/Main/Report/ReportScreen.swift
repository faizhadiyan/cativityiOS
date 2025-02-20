//
//  ReportScreen.swfit.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct ReportScreen: View {
    @State private var shareImageURL: URL?
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack (alignment: .top) {
                    Text("Capaian")
                        .frame( alignment: .leading)
                        .padding(.leading, 16)
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                    Spacer()
                    
                    Button("Bagikan", systemImage: "square.and.arrow.up") {
                        if let image = ImageRenderer(content: reportScreen()).uiImage,
                           let url = saveImageToTemporaryDirectory(image) {
                            shareImageURL = url
                            
                            shareImage(imageURL: url)
                        }
                        
                    }
                }
                ScrollView {
                    reportScreen()
                }
            }
        }
    }
}

private func reportScreen() -> some View {
    VStack {
        StreakView()
        ItemReportView()
            .background(.white)
    }
}

func shareImage(imageURL: URL) {
    let activityVC = UIActivityViewController(activityItems: [imageURL], applicationActivities: nil)
    
    // Get the top-most view controller to present the activity view controller
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let topController = windowScene.windows.first?.rootViewController {
        
        // Find the top-most presented view controller
        var presentController = topController
        while let presentedVC = presentController.presentedViewController {
            presentController = presentedVC
        }
        
        presentController.present(activityVC, animated: true, completion: nil)
    }
}

func saveImageToTemporaryDirectory(_ image: UIImage) -> URL? {
    let filename = UUID().uuidString + ".jpg"
    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
    
    guard let data = image.pngData() else { return nil }
    
    do {
        try data.write(to: fileURL)
        return fileURL
    } catch {
        print("Error saving image to temporary directory: \(error)")
        return nil
    }
}

func share(image: UIImage) {
    let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first,
       let rootViewController = window.rootViewController {
        
        // Find the top-most view controller to present the activity view controller
        var topController = rootViewController
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        topController.present(activityVC, animated: true, completion: nil)
    }
}

struct TransferableImage: Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(exportedContentType: .image) { transferableImage in
            return SentTransferredFile(transferableImage.url)
        }
    }
}

#Preview {
    ReportScreen()
}
