//
//  SwiftUI+View.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 09/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

extension View {
 
    // Prints out all the given variables.
    // Can be used to debug variables in Views
    func Print(_ vars: Any...) -> some View {
        vars.forEach { print($0) }
        return EmptyView()
    }
    
}
