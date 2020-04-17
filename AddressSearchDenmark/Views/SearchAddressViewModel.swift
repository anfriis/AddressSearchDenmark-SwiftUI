//
//  SearchAddressViewModel.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class SearchAddressViewModel: ObservableObject {

    private let service: SearchAddressService
    private var disposables = Set<AnyCancellable>()
    
    @Published var addresses: [Address] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    @Published var newAddresses: [Address] = []
    
    init(service: SearchAddressService) {
        self.service = service
    
        self.service.newAddressesSubject
            .assign(to: \.newAddresses, on: self)
            .store(in: &self.disposables)
        
        self.$searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: self.queryAddresses)
            .store(in: &self.disposables)
    }
    
    func queryAddresses(searchText: String) {
        guard searchText.isEmpty == false else {
            self.addresses = []
            return
        }
        
        self.isLoading = true
        self.service
            .queryAddresses(searchText: searchText)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.addresses = []
                    default: break
                    }
                    self.isLoading = false
                },
                receiveValue: { [weak self] addresses in
                    guard let self = self else { return }
                    self.addresses = addresses
            })
            .store(in: &disposables)
    }
    
    func delete(at offset: IndexSet) {
        self.service.removeAddresses(at: offset)
    }
    
}
