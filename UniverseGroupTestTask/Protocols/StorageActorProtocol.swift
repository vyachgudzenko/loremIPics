//
//  CoreDataActorProtocol.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import Foundation

protocol StorageActorProtocol{
    func getAllFavorites() async -> [FavoriteDTO]
    func saveFavorite(_ dto: FavoriteDTO) async throws
    func deleteFavorite(id: String) async throws
}
