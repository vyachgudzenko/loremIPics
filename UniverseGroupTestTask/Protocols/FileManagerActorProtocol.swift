//
//  FileManagerActorProtocol.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import Foundation

protocol FileManagerActorProtocol {
    func createFolder(named folderName: String) async throws
    func writeFile(data: Data, to folderName: String, fileName: String) async throws
    func readFile(from folderName: String, fileName: String) async -> Data?
    func listFiles(in folderName: String) async -> [URL]
}
