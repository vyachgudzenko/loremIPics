//
//  PhotoInfo.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 19.11.2025.
//

import Foundation

struct PhotoInfo: Decodable, Sendable, PhotoInfoCellProtocol {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
    
    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.url = try container.decode(String.self, forKey: .url)
        self.downloadURL = try container.decode(String.self, forKey: .downloadURL)
    }
}
