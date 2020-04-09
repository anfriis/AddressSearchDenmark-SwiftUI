//
//  SearchAddressViewModel.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation
import Combine

class SearchAddressViewModel: ObservableObject {
    
    @Published var addresses: [Address] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private let service: SearchAddressService
    private var disposables = Set<AnyCancellable>()
    
    
    init(service: SearchAddressService) {
        self.service = service
        
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0.isEmpty == false }
            .sink(receiveValue: queryAddresses)
            .store(in: &self.disposables)
    }
    
    func queryAddresses(searchText: String) {
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
    
}
