//
//  Networking.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import Foundation
import Combine

struct NetworkClient {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(
        _ request: URLRequest,
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Response<T>, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                Response(
                    value: try decoder.decode(T.self, from: result.data),
                    response: result.response
                )
        }
        .eraseToAnyPublisher()
    }
    
}
