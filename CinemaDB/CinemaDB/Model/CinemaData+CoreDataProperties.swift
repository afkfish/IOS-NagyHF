//
//  CinemaData+CoreDataProperties.swift
//  CinemaDB
//
//  Created by Beni Kis on 06/12/2023.
//
//

import Foundation
import CoreData


extension CinemaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CinemaData> {
        return NSFetchRequest<CinemaData>(entityName: "CinemaData")
    }

    @NSManaged public var id: String?
    @NSManaged public var groupId: String?
    @NSManaged public var displayName: String?
    @NSManaged public var link: URL?
    @NSManaged public var imageUrl: URL?
    @NSManaged public var address: String?
    @NSManaged public var bookingUrl: URL?
    @NSManaged public var blockOnlineSales: Bool
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var dateCreated: Date?

}

extension CinemaData : Identifiable {

}
