//
//  Cinema.swift
//  CinemaDB
//
//  Created by Beni Kis on 02/12/2023.
//

import Foundation
import CoreData

struct CinemaResponse: Codable {
    var body: CinemaBody
}

struct CinemaBody: Codable {
    var cinemas: [Cinema]
}

struct Cinema: Identifiable, Codable {
    var id: String
    var groupId: String
    var displayName: String
    var link: String
    var imageUrl: String
    var address: String
    var addressInfo: AddressInfo
    var bookingUrl: String
    var blockOnlineSales: Bool
    var blockOnlineSalesUntil: String?
    var latitude: Double
    var longitude: Double
}

struct AddressInfo: Codable {
    var address1: String?
    var address2: String?
    var address3: String?
    var address4: String?
    var city: String?
    var state: String?
    var postalCode: String?
}

extension Cinema {
    static var dummy: Cinema {
        Cinema(
            id: "1135",
            groupId: "group-1135",
            displayName: "Zalaegerszeg",
            link: "https://www.cinemacity.hu/cinemas/zala",
            imageUrl: "https://www.cinemacity.hu/static/dam/jcr:f24a3181-2846-48cb-b8da-b93e67463441",
            address: "Stadion utca 5., 06 80 800 800, Zalaegerszeg",
            addressInfo: AddressInfo(address1: "Stadion utca 5.", address2: nil, address3: nil, address4: nil, city: "Zalaegerszeg", state: "8900", postalCode: "06 80 800 800"),
            bookingUrl: "https://booking.cinemacity.hu/SalesHU?key=HUzalaP_RES",
            blockOnlineSales: false,
            blockOnlineSalesUntil: nil,
            latitude: 46.847446,
            longitude: 16.852085
        )
    }
}

extension CinemaData {
    convenience init(from cinema: Cinema, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = cinema.id
        self.groupId = cinema.groupId
        self.displayName = cinema.displayName
        self.link = URL(string: cinema.link)!
        self.imageUrl = URL(string: cinema.imageUrl)!
        self.address = cinema.address
        self.bookingUrl = URL(string: cinema.bookingUrl)!
        self.blockOnlineSales = cinema.blockOnlineSales
        self.latitude = cinema.latitude
        self.longitude = cinema.longitude
        self.dateCreated = Date()
    }
}

extension Cinema {
    static func convert(from data: [CinemaData]) -> [Cinema] {
        data.map {
            Cinema(
                id: $0.id!,
                groupId: $0.groupId!,
                displayName: $0.displayName!,
                link: $0.link!.absoluteString,
                imageUrl: $0.imageUrl!.absoluteString,
                address: $0.address!,
                addressInfo: AddressInfo(),
                bookingUrl: $0.bookingUrl!.absoluteString,
                blockOnlineSales: $0.blockOnlineSales,
                latitude: $0.latitude,
                longitude: $0.longitude
            )
        }
    }
}
