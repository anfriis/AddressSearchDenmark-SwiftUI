//
//  SearchAddressService.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation
import Combine

protocol SearchAddressService {
    func queryAddresses(searchText: String) -> AnyPublisher<[Address], Error>
}

class AppSearchAddressService: SearchAddressService {
    
    func queryAddresses(searchText: String) -> AnyPublisher<[Address], Error> {
        AddressAPI
            .query(searchText: searchText)
            .map { res in
                res.compactMap({ Address(address: $0) })
        }
        .eraseToAnyPublisher()
    }
    
}
