//
//  Favorite+CoreDataProperties.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//
//

public import Foundation
public import CoreData


public typealias FavoriteCoreDataPropertiesSet = NSSet

extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: String?
    @NSManaged public var createdAt: Date?

}

extension Favorite : Identifiable { }

extension Favorite : PhotoInfoCellProtocol {
    var idForPhotoCell: String{
        if let id{
            return id
        }
        return "-1"
    }
}


