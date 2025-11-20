//
//  FileCacheService.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 20.11.2025.
//

import Foundation
import UIKit

actor CacheService {

    private var memoryCache: [String: Data] = [:]
    private let fileManager: FileManagerActor
    private let folderName: String

    init(folderName: String = "Cache", fileManager: FileManagerActor = FileManagerActor()) async {
        self.folderName = folderName
        self.fileManager = fileManager
        try? await fileManager.createFolder(named: folderName)
        await loadCacheFromDisk()
    }

    
    func addToCache(name: String, data: Data) async {
        memoryCache[name] = data
        do {
            try await fileManager.writeFile(data: data, to: folderName, fileName: name)
        } catch {
            print("Failed to save \(name) to disk: \(error)")
        }
    }

    
    func getFromCache(name: String) async -> Data? {
        if let data = memoryCache[name] {
            return data
        }

        if let data = await fileManager.readFile(from: folderName, fileName: name) {
            memoryCache[name] = data 
            return data
        }

        return nil
    }

    
    private func loadCacheFromDisk() async {
        
        let files = await fileManager.listFiles(in: folderName)
        for fileURL in files {
            let name = fileURL.lastPathComponent
            if let data = await fileManager.readFile(from: folderName, fileName: name) {
                memoryCache[name] = data
            }
        }
    }
}
