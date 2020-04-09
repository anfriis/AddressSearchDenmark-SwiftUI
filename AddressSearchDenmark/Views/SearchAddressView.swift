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
   
    @ObservedObject var viewModel: SearchAddressViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $viewModel.searchText, isLoading: $viewModel.isLoading)
                List(viewModel.addresses) { address in
                    NavigationLink(destination: Text("Detail for \(address.title)")) {
                        VStack(alignment: .leading) {
                            Text(address.title).font(.headline)
                            Text(address.subtitle)
                        }.frame(height: 65)
                    }
                }
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
        }
        
    }
}

struct SearchAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.makeSearchAddressView()
    }
}