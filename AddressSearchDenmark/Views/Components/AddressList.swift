//
//  NewAddressesList.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 17/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct AddressList: View {
    
    var addresses: [Address]
    var delete: ((IndexSet) -> ())?
    
    init(
        _ addresses: [Address] = [],
        delete: ((IndexSet) -> ())? = { _ in }
    ) {
        self.addresses = addresses
        self.delete = delete
    }
    
    var body: some View {
        List {
            ForEach(addresses) { address in
                NavigationLink(destination: ViewFactory.default.makeAddressMapView(address: address)) {
                    AddressRow(address: address)
                }
            }
            .onDelete(perform: delete)
        }
    }
    
}

struct AddressList_Previews: PreviewProvider {
    static var previews: some View {
        AddressList([Address.default, Address.default])
    }
}
