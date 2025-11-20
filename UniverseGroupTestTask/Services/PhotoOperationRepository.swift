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
    
    init() async{
        apiService = await APIServiceActor()
        fileManager = FileManagerActor()
    }
    
    func fetchPhotoInfos() async throws -> [PhotoInfo]{
        let result = try await apiService.fetchPhotoInfos()
        return result
    }
    
    func getImageByID(_ id: String,width: Int = 300,height: Int = 200) async throws -> UIImage?{
        if let data = try await apiService.getImageDataByID(id, width: width, height: height){
            return  UIImage(data: data)
        }
        return nil
    }
}

