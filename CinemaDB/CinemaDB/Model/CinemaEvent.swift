//
//  CinemaEvent.swift
//  CinemaDB
//
//  Created by Beni Kis on 06/12/2023.
//

import Foundation


struct CinemaEventResponse: Codable {
    var body: CinemaEventBody
}

struct CinemaEventBody: Codable {
    var films: [Film]
    var events: [CinemaEvent]
}

struct CinemaEvent: Codable {
    var id: String
    var filmId: String
    var cinemaId: String
    var businessDay: String
    var eventDateTime: String
    var attributeIds: [String]
    var bookingLink: String
    var compositeBookingLink: CompositeBookingLink
    var soldOut: Bool
    var auditorium: String
}

struct CompositeBookingLink: Codable {
    var type: String
    var bookingUrl: BookingUrl
}

struct BookingUrl: Codable {
    var url: String
    var params: Params
}

struct Params: Codable {
    var lang: String
    var key: String
}

