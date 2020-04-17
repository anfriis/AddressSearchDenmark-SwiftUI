//
//  ViewFactory.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 09/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//
import SwiftUI

struct ViewFactory {
    
    let searchAddressService: SearchAddressService
    
    func makeSearchAddressView() -> some View {
        let viewModel = SearchAddressViewModel(service: self.searchAddressService)
        return SearchAddressView().environmentObject(viewModel)
    }
    
    func makeAddressMapView(address: Address = Address.default) -> some View {
        let viewModel = AddressMapViewModel(address: address)
        return AddressMapView().environmentObject(viewModel)
    }
    
    func makeCreateAddressView(isPresented: Binding<Bool>) -> some View {
        let viewModel = CreateAddressViewModel(service: self.searchAddressService)
        return CreateAddressView(isPresented: isPresented).environmentObject(viewModel)
    }
    
}

extension ViewFactory {
    
    static let `default` = Self(searchAddressService: AppSearchAddressService())
    
}
