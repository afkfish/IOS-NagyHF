//
//  FilmData+CoreDataProperties.swift
//  CinemaDB
//
//  Created by Beni Kis on 04/12/2023.
//
//

import Foundation
import CoreData


extension FilmData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilmData> {
        return NSFetchRequest<FilmData>(entityName: "FilmData")
    }

    @NSManaged public var attributeIds: [NSString]
    @NSManaged public var id: String?
    @NSManaged public var length: Int16
    @NSManaged public var link: URL?
    @NSManaged public var name: String?
    @NSManaged public var posterLink: URL?
    @NSManaged public var releaseYear: Int16
    @NSManaged public var videoLink: URL?
    @NSManaged public var dateCreated: Date?

}

extension FilmData : Identifiable {

}
