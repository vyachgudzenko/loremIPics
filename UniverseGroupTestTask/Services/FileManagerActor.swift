//
//  FileManagerActor.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 20.11.2025.
//

import Foundation

actor FileManagerActor: FileManagerActorProtocol {
    
    private let fileManager = FileManager.default
    
    private func documentsDirectory() -> URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func folderExists(named folderName: String) -> Bool {
        let folderURL = documentsDirectory().appendingPathComponent(folderName)
        var isDir: ObjCBool = false
        let exists = fileManager.fileExists(atPath: folderURL.path, isDirectory: &isDir)
        return exists && isDir.boolValue
    }
    
    func createFolder(named folderName: String) async throws {
        let folderURL = documentsDirectory().appendingPathComponent(folderName)
        if !folderExists(named: folderName) {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
    }
    
    func fileExists(in folderName: String, fileName: String) -> Bool {
        let fileURL = documentsDirectory()
            .appendingPathComponent(folderName)
            .appendingPathComponent(fileName)
        return fileManager.fileExists(atPath: fileURL.path)
    }
    
    func writeFile(data: Data, to folderName: String, fileName: String) async throws {
        try await createFolder(named: folderName) // ensure folder exists
        let fileURL = documentsDirectory()
            .appendingPathComponent(folderName)
            .appendingPathComponent(fileName)
        try data.write(to: fileURL, options: .atomic)
    }
    
    func readFile(from folderName: String, fileName: String) async -> Data? {
        let fileURL = documentsDirectory()
            .appendingPathComponent(folderName)
            .appendingPathComponent(fileName)
        return try? Data(contentsOf: fileURL)
    }
    
    func listFiles(in folderName: String) async -> [URL] {
        let folderURL = documentsDirectory().appendingPathComponent(folderName)
        do {
            let contents = try fileManager.contentsOfDirectory(
                at: folderURL,
                includingPropertiesForKeys: nil,
                options: [.skipsHiddenFiles]
            )
            return contents
        } catch {
            print("Failed to list files in folder \(folderName): \(error)")
            return []
        }
    }
}
