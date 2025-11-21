//
//  CacheServiceProtocol.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import Foundation

protocol CacheServiceProtocol {
    func addToCache(name: String, data: Data) async
    func getFromCache(name: String) async -> Data?
    func loadCacheFromDisk() async
}
