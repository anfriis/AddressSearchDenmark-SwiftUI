//
//  Address.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation

struct AddressResponse: Codable {
    let id: String
    let x, y: Double
    let betegnelse: String
}

struct Address: Codable, Identifiable {
    let id: String
    let title: String
    let subtitle: String
    
    init(id: String, title: String, subtitle: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }
    
    init?(address: AddressResponse) {
        self.id = address.id
        let str = address.betegnelse.split(separator: ",", maxSplits: 1, omittingEmptySubsequences: true)
        
        guard let title = str.first,
            let subTitle = str.last else { return nil }
        self.title = String(title).trim()
        self.subtitle = String(subTitle).trim()
    }
    
}
