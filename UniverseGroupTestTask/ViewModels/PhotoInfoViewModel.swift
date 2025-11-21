//
//  PhotoInfoViewModel.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 20.11.2025.
//

import SwiftUI
import Combine

@MainActor
class PhotoInfoViewModel: ObservableObject {
    
    private var repository:(any RepositoryProtocol)?
    private var storage: (any StorageActorProtocol)?
    
    @Published var photoInfos: [PhotoInfo] = []
    @Published var favorites: [FavoriteDTO] = []
    
    @Published var errorMessage: String = "Error loading photo info"
    @Published var showError: Bool = false
    @Published var initialDataLoaded: Bool = false
    
    init() {
        Task { [weak self] in
            let repo = await PhotoOperationRepository()
            self?.repository = repo
            let coreData = await CoreDataActor()
            self?.storage = coreData
            await self?.loadInitialData()
            await self?.getFavorites()
        }
    }
    
    func loadInitialData() async {
        print("loading data start")
        guard let repository else { return }
        do {
            let infos = try await repository.fetchPhotoInfos()
            self.photoInfos = infos
            self.initialDataLoaded = true
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func getImageByID(_ id: String, width: Int = 300, height: Int = 300) async throws -> UIImage?{
        let uiImage = try await repository?.getImageByID(id, width: width, height: height)
        return uiImage
    }
    
    func manageFavoriteStateByID(id: String) async {
        if isFavorite(id: id){
           await removeFromFavorites(id: id)
        } else {
           await addToFavorites(id: id)
        }
    }
    
    private func addToFavorites(id: String) async{
        guard let coreDataService = storage else { return }
        let dto = FavoriteDTO(id: id, createAt: Date())
        do{
           try await coreDataService.saveFavorite(dto)
            favorites.append(dto)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        
    }
    
    
    private func removeFromFavorites(id: String) async{
        guard let coreDataService = storage else { return }
        do{
            try await coreDataService.deleteFavorite(id: id)
            withAnimation(.bouncy){
                favorites.removeAll(where: { $0.id == id })
            }
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func getFavorites() async{
        guard let coreDataService = storage else { return }
        let results = await coreDataService.getAllFavorites()
        favorites = results
    }
    
    func isFavorite(id: String) -> Bool{
        return favorites.contains(where: { $0.id == id })
        
    }
}
