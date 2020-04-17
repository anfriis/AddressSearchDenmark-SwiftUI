//
//  AddressRow.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 14/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct AddressRow: View {

    var address: Address
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(address.title).font(.headline)
            Text(address.subtitle)
        }.frame(height: 65)
    }
    
}

struct AddressRow_Previews: PreviewProvider {
    static var previews: some View {
        AddressRow(address: Address.default)
    }
}
