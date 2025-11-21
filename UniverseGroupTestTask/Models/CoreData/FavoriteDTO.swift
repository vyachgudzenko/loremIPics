//
//  FavoriteDTO.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import Foundation

struct FavoriteDTO: Sendable, PhotoInfoCellProtocol{
    
    let id: String
    let createAt: Date
    
    var idForPhotoCell: String{
        return id
    }
}
