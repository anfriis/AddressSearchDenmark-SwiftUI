//
//  MapView.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 14/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let delta = 0.02
        let region = MKCoordinateRegion(
            center: self.coordinate,
            span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        )
        uiView.setRegion(region, animated: true)
        uiView.addAnnotations([AddressAnnotation(coordinate: self.coordinate)])
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: Address.default.coordinate)
    }
}
