//
//  SearchAddressView.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI
import Combine

struct SearchAddressView: View {
    
    @EnvironmentObject var viewModel: SearchAddressViewModel
    @State var presentCreateAddress = false
    var showNewAddresses: Bool {
        viewModel.addresses.isEmpty
    }
    
    var createAddressView: some View {
        ViewFactory.default.makeCreateAddressView(isPresented: self.$presentCreateAddress)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(
                    searchText: $viewModel.searchText,
                    isLoading: $viewModel.isLoading
                )
                
                AddressList(
                    self.showNewAddresses ?
                        viewModel.newAddresses :
                        viewModel.addresses,
                    delete: self.showNewAddresses ? self.delete : nil
                )
                    
                    .navigationBarTitle(Text("Search"))
                    .navigationBarItems(
                        trailing:
                        Button(action: { self.presentCreateAddress = true }) {
                            Text("Create address")
                        }
                )
            }
        }
        .sheet(isPresented: $presentCreateAddress) {
            self.createAddressView
        }
    }
    
    func delete(at offsets: IndexSet) {
        self.viewModel.delete(at: offsets)
    }
    
}

struct SearchAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.default.makeSearchAddressView()
    }
}
