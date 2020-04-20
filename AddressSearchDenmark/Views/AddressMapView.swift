//
//  AddressMapView.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 14/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct AddressMapView: View {
    
    @EnvironmentObject var viewModel: AddressMapViewModel
    
    var body: some View {
        ZStack {
            MapView(coordinate: viewModel.address.coordinate)
                        
            DraggableCard() {
                VStack {
                    VStack(alignment: .leading) {
                        Text(self.viewModel.address.title).font(.headline)
                        Text(self.viewModel.address.subtitle)
                    }
                    Spacer()
                }
                .padding(10)
            }
        }
        .navigationBarTitle("Map", displayMode: .inline)
    }
    
}

struct AddressMapView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.default.makeAddressMapView()
    }
}
