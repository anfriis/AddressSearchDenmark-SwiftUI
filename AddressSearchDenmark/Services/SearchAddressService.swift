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
    var newAddressesSubject: PassthroughSubject<[Address], Never> { get }
    func queryAddresses(searchText: String) -> AnyPublisher<[Address], Error>
    func addNewAddress(address: Address)
    func removeAddresses(at offsets: IndexSet)
}

class AppSearchAddressService: SearchAddressService {

    private var disposables = Set<AnyCancellable>()
    @Published var newAddresses: [Address] = []
    
    lazy var newAddressesSubject: PassthroughSubject<[Address], Never> = {
        let sub = PassthroughSubject<[Address], Never>()
        self.$newAddresses.subscribe(sub)
            .store(in: &self.disposables)
        return sub
    }()
    
    func queryAddresses(searchText: String) -> AnyPublisher<[Address], Error> {
        AddressAPI
            .query(searchText: searchText)
            .map { res in
                res.compactMap({ Address(address: $0) })
        }
        .eraseToAnyPublisher()
    }
    
    func addNewAddress(address: Address) {
        self.newAddresses.append(address)
    }
 
    func removeAddresses(at offsets: IndexSet) {
        self.newAddresses.remove(atOffsets: offsets)
    }

}
