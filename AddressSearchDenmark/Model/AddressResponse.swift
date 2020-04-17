//
//  AddressResponse.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 17/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation

struct AddressResponse: Codable {
    let id: String
    let x, y: Double
    let betegnelse: String
}
