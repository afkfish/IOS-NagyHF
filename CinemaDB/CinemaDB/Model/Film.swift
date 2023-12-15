//
//  Film.swift
//  CinemaDB
//
//  Created by Beni Kis on 02/12/2023.
//

import Foundation
import CoreData

struct FilmResponse: Codable {
    var body: Body
}

struct Body: Codable {
    var films: [Film]
}

struct Film: Identifiable, Codable {
    var id: String
    var name: String
    var length: Int
    var posterLink: String
    var videoLink: String
    var link: String
    var releaseYear: String
    var attributeIds: [String]
}

extension Film {
    static var dummy: Film {
        Film(id: "5874d2r",
             name: "Állati iramban",
             length: 93,
             posterLink: "https://www.cinemacity.hu/xmedia-cw/repo/feats/posters/5874D2R.jpg",
             videoLink: "https://www.youtube.com/watch?v=53gEQMAuxbQ",
             link: "https://www.cinemacity.hu/films/allati-iramban/5874d2r",
             releaseYear: "2023",
             attributeIds: ["12-plus", "2d", "animation", "dubbed", "dubbed-lang-hu", "family"]
        )
    }
}

extension FilmData {
    convenience init(from film: Film, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = film.id
        self.name = film.name
        self.length = Int16(film.length)
        self.posterLink = URL(string: film.posterLink)!
        self.videoLink = URL(string: film.videoLink)!
        self.link = URL(string: film.link)!
        self.releaseYear = Int16(film.releaseYear)!
        self.attributeIds = film.attributeIds as [NSString]
        self.dateCreated = Date()
    }
}

extension Film {
    static func convert(from data: [FilmData]) -> [Film] {
        data.map {
            Film(
                id: $0.id!,
                name: $0.name!,
                length: Int($0.length),
                posterLink: $0.posterLink!.absoluteString,
                videoLink: $0.videoLink!.absoluteString,
                link: $0.link!.absoluteString,
                releaseYear: String($0.releaseYear),
                attributeIds: $0.attributeIds as [String]
            )
        }
    }
}
