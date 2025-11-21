//
//  TabScreen.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import Foundation

enum TabScreen:String, CaseIterable{
    case images
    case favorites
    
    var title: String{
        switch self {
        case .images:
            "Images"
        case .favorites:
            "Favorites"
        }
    }
    
    func currentImageName(isSelected: Bool) -> String {
        let tail: String = isSelected ? "_fill" : ""
        return "\(self.rawValue)\(tail)"
    }
}
