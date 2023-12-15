//
//  GroupsWithFilm.swift
//  CinemaDB
//
//  Created by Beni Kis on 07/12/2023.
//

import Foundation

struct GroupsWithFilmResponse: Codable {
    var body: Groups
}

struct Groups: Codable {
    var groups: [CGroup]
    
    
}

struct CGroup: Codable {
    var cinemaIds: [String]
}
