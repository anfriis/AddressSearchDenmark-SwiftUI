//
//  SwiftUI+View.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 09/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
