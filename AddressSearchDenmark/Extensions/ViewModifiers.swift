//
//  ViewModifiers.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 09/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
}

extension View {
    
    func hiddenNavigationBarStyle() -> some View {
        ModifiedContent(content: self, modifier: HiddenNavigationBar())
    }
    
}
