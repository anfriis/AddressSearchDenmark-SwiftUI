//
//  Address.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation
import MapKit

struct Address: Codable, Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let x, y: Double
    
    init(id: String, title: String, subtitle: String, x: Double, y: Double) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.x = x
        self.y = y
    }
    
    init?(address: AddressResponse) {
        let str = address.betegnelse.split(separator: ",", maxSplits: 1, omittingEmptySubsequences: true)
        
        guard let title = str.first,
            let subTitle = str.last
            else { return nil }
        
        self.id = address.id
        self.title = String(title).trim()
        self.subtitle = String(subTitle).trim()
        self.x = address.x
        self.y = address.y
    }
    
}

extension Address {
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2DMake(self.y, self.x)
    }

    static let `default` = Self(id: "1", title: "Frederiksberg Alle 2", subtitle: "1600 Frederiksberg", x: 12.549739, y: 55.673012)
    
}
