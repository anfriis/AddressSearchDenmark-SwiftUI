//
//  InputValidation.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 15/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation

enum InputValidation {
    case pending, error, valid
}

extension InputValidation {
    
    static func getAddressTitleValidation(str: String) -> InputValidation {
        var validation = InputValidation.pending
        if 0 < str.count {
            if 2 <= str.count {
                validation = .valid
            } else {
                validation = .error
            }
            
        }
        return validation
    }
    
}
