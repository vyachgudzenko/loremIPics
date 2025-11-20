//
//  APIServiceProtocol.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 20.11.2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchPhotoInfos() async throws -> [PhotoInfo]
    func getImageDataByID(_ id: String,width: Int,height: Int) async throws -> Data?
}
