//
//  AddressMapViewModel.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 14/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation
import Combine
import MapKit

class AddressMapViewModel: ObservableObject {
    
    let address: Address
    
    init(address: Address) {
        self.address = address
    }
    
}
