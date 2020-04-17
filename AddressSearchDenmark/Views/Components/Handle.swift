//
//  Handle.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 14/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct Handle: View {
    private let handleThickness = CGFloat(5.0)
    
    var body: some View {
        RoundedRectangle(cornerRadius: self.handleThickness / 2)
            .frame(width: 50, height: self.handleThickness)
            .foregroundColor(Color.gray)
            .padding(5.0)
    }
}
