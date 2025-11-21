//
//  PhotoOperationRepository.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 20.11.2025.
//

import Foundation
import UIKit

actor PhotoOperationRepository: RepositoryProtocol{
    private let apiService: any APIServiceProtocol
    private let cacheService: any CacheServiceProtocol
    
    
    init() async{
        
        async let initApi = APIServiceActor()
        async let initCache = CacheService()
        
        cacheService = await initCache
        apiService = await initApi
        
    }
    
    func fetchPhotoInfos() async throws -> [PhotoInfo]{
        let result = try await apiService.fetchPhotoInfos()
        return result
    }
    
    func getImageByID(_ id: String, width: Int = 300, height: Int = 200) async throws -> UIImage? {
        let fileName = "\(id)_\(width)x\(height).jpg"
        if let cachedData = await cacheService.getFromCache(name: fileName),
           let image = UIImage(data: cachedData) {
            print("id \("\(id)/\(width)/\(height).jpg")) is in cache")
            return image
        }
        
        guard let data = try await apiService.getImageDataByID(id, width: width, height: height) else {
            return nil
        }
        
        await cacheService.addToCache(name: fileName, data: data)
        
        return UIImage(data: data)
    }
}

