//
//  MapView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/16.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var location: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        view.setRegion(region, animated: true)
    }
}
