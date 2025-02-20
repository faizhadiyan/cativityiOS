//
//  MapView.swift
//  Cativity
//
//  Created by Wahyu Untoro on 16/05/24.
//

import Foundation
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @Binding var selectedCoordinate: CLLocationCoordinate2D
    @Binding var region: MKCoordinateRegion
    @Binding var isFirstOpen: Bool
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
            let locationInView = gestureRecognizer.location(in: gestureRecognizer.view)
            let mapView = gestureRecognizer.view as! MKMapView
            let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            parent.selectedCoordinate = coordinate
            
            // Remove existing annotations
            mapView.removeAnnotations(mapView.annotations)
            
            // Add new annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let gestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(gestureRecognizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if (isFirstOpen) {
            uiView.setRegion(region, animated: true)
        }
        
        // Remove existing annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add new annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = selectedCoordinate
        uiView.addAnnotation(annotation)
    }
}
