//
//  UserData.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 16/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var newAddresses: [Address] = []
}
