//
//  CreateAddressViewModel.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 15/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class CreateAddressViewModel: ObservableObject {

    private let service: SearchAddressService
    private var disposables = Set<AnyCancellable>()
    
    @Published var title: String = ""
    @Published var subtitle: String = ""
    
    @Published var titleValidation: InputValidation = .pending
    @Published var subtitleValidation: InputValidation = .pending
    
    @Published var validationResult: InputValidation = .pending
    
    init(service: SearchAddressService) {
        self.service = service

        $title
            .removeDuplicates()
            .map { InputValidation.getAddressTitleValidation(str: $0) }
            .assign(to: \.titleValidation, on: self)
            .store(in: &self.disposables)
        
        $subtitle
            .removeDuplicates()
            .map { InputValidation.getAddressTitleValidation(str: $0) }
            .assign(to: \.subtitleValidation, on: self)
            .store(in: &self.disposables)
        
        Publishers.CombineLatest($titleValidation, $subtitleValidation)
            .map { title, subtitle in
                if title == .valid && subtitle == .valid {
                    return .valid
                } else if title == .error || subtitle == .error {
                    return .error
                }
                return .pending
        }
        .assign(to: \.validationResult, on: self)
        .store(in: &self.disposables)
    }
    
    func createAddress() {
        let address = Address(id: UUID.init().uuidString, title: self.title, subtitle: self.subtitle, x: 50, y: 12)
        self.service.addNewAddress(address: address)
    }
    
}
