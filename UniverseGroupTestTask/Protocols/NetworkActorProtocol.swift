//
//  NetworkActorProtocol.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 19.11.2025.
//

import Foundation

protocol NetworkActorProtocol{
    func sendRequest<T: Decodable>(_ request: URLRequest, decodeTo type: T.Type) async throws -> T
}
