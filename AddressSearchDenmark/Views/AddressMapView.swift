//
//  AddressMapView.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 14/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct AddressMapView: View {
    
    @ObservedObject var viewModel: AddressMapViewModel
    
    var body: some View {
        ZStack {
            MapView(coordinate: viewModel.address.coordinate)
                .edgesIgnoringSafeArea(.top)
            
            DraggableCardView() {
                VStack {
                    VStack(alignment: .leading) {
                        Text(self.viewModel.address.title).font(.headline)
                        Text(self.viewModel.address.subtitle)
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding(10)
            }
        }
    }
    
}

struct AddressMapView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.makeAddressMapView()
    }
}
