//
//  CoreDataActor.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import Foundation
@preconcurrency import CoreData

actor CoreDataActor: storageActorProtocol {

    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    init() async {
        container = NSPersistentContainer(name: "UniverseGroupTestTask")
        context = container.newBackgroundContext()
        
        await loadPersistentStore()
    }

    private func loadPersistentStore() async {
        await withCheckedContinuation { continuation in
            container.loadPersistentStores { _, error in
                continuation.resume()
                if let error = error {
                    print("Failed to load persistent store:", error)
                }
            }
        }
    }

    func getAllFavorites() async -> [FavoriteDTO] {
        let request = await Favorite.fetchRequest()

        return await withCheckedContinuation { continuation in
            context.perform {
                do {
                    let objects = try self.context.fetch(request)
                    let result = objects.compactMap { obj in
                        if let id = obj.id,
                           let createdAt = obj.createdAt {
                            return FavoriteDTO(id: id, createAt: createdAt)
                        }
                        return nil
                    }
                    continuation.resume(returning: result)
                } catch {
                    print("Fetch error:", error)
                    continuation.resume(returning: [])
                }
            }
        }
    }


    func saveFavorite(_ dto: FavoriteDTO) async throws {
        try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    let object = Favorite(context: self.context)
                    object.id = dto.id
                    object.createdAt = dto.createAt
                    try self.context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }


    func deleteFavorite(id: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            context.perform {
                let request = Favorite.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", id)

                do {
                    let objs = try self.context.fetch(request)
                    for obj in objs {
                        self.context.delete(obj)
                    }
                    try self.context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
