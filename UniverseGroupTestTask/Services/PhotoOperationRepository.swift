//
//  PhotoOperationRepository.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 20.11.2025.
//

import Foundation
import UIKit

actor PhotoOperationRepository{
    private let apiService: any APIServiceProtocol
    private let fileManager: FileManagerActor
    private let cacheService: CacheService
    
    init() async{
        fileManager = FileManagerActor()
        cacheService = await CacheService(fileManager: fileManager)
        apiService = await APIServiceActor()
        
    }
    
    func fetchPhotoInfos() async throws -> [PhotoInfo]{
        let result = try await apiService.fetchPhotoInfos()
        return result
    }
    
    func getImageByID(_ id: String, width: Int = 300, height: Int = 200) async throws -> UIImage? {
            
            if let cachedData = await cacheService.getFromCache(name: "\(id)/\(width)/\(height).jpg"),
               let image = UIImage(data: cachedData) {
                print("id \("\(id)/\(width)/\(height).jpg")) is in cache")
                return image
            }
            
            
            guard let data = try await apiService.getImageDataByID(id, width: width, height: height) else {
                return nil
            }
            
            await cacheService.addToCache(name: "\(id)/\(width)/\(height).jpg", data: data)
            
            return UIImage(data: data)
        }
}

