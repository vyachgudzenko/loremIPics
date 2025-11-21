//
//  RepositoryProtocol.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import Foundation
import UIKit

protocol RepositoryProtocol {
    func fetchPhotoInfos() async throws -> [PhotoInfo]
    func getImageByID(_ id: String, width: Int, height: Int) async throws -> UIImage?
    
}
