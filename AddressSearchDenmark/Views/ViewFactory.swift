//
//  ViewFactory.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 09/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//
import SwiftUI

struct ViewFactory {
    
    static let searchAddressService: SearchAddressService = AppSearchAddressService()
    
    static func makeSearchAddressView() -> some View {
        let viewModel = SearchAddressViewModel(
            service: ViewFactory.searchAddressService
        )
        return SearchAddressView(viewModel: viewModel)
    }
}
