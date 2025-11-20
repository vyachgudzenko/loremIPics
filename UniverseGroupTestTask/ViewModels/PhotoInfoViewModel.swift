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
    
    private var repository: PhotoOperationRepository?
    
    @Published var photoInfos: [PhotoInfo] = []
    
    @Published var errorMessage: String = "Error loading photo info"
    @Published var showError: Bool = false
    
    init() {
        Task { [weak self] in
            let repo = await PhotoOperationRepository()
            self?.repository = repo
            await self?.loadInitialData()
        }
    }
    
    private func loadInitialData() async {
        guard let repository else { return }
        do {
            let infos = try await repository.fetchPhotoInfos()
            self.photoInfos = infos
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func getImageByID(_ id: String, width: Int = 300, height: Int = 200) async throws -> UIImage?{
        let uiImage = try await repository?.getImageByID(id, width: 300, height: 200)
        return uiImage
    }
}
