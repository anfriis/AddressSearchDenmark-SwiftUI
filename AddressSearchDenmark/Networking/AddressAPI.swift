//
//  API.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation
import Combine

enum AddressAPI {
    static let client = NetworkClient()
    static let base = URL(string: "https://dawa.aws.dk")!
}

extension AddressAPI {
    
    static func query(searchText: String) -> AnyPublisher<[AddressResponse], Error> {
        var components = URLComponents(url: AddressAPI.base, resolvingAgainstBaseURL: true)
        components?.path = "/adgangsadresser"
        let queryItems = [
            URLQueryItem(name: "autocomplete", value: "true"),
            URLQueryItem(name: "q", value: searchText)
        ]
        components?.queryItems = queryItems

        guard let url = components?.url else {
            fatalError("Invalid URL: \(String(describing: components?.debugDescription))")
        }
        
        let request = URLRequest(url: url)
        return client.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
}
