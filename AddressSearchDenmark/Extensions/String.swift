//
//  String.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
