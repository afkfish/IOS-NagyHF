//
//  FilmDetailsScrollView.swift
//  CinemaDB
//
//  Created by Beni Kis on 07/12/2023.
//

import SwiftUI

struct FilmDetailsScrollView: View {
    @Environment(\.colorScheme) var colorscheme
    @Binding var film: Film
    @State var cinemaEvents: [CinemaEvent]
    @State var cinemas: [Cinema]
    
    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 200)
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                let nameLink = "[\(film.name)](\(film.link))"
                Text(.init(nameLink))
                    .padding(.vertical)
                    .font(.system(size: 30, weight: .heavy))
                HStack {
                    Text("Release Year: ")
                        .font(.system(size: 20, weight: .bold))
                    Text(film.releaseYear)
                }
                .padding(.bottom)
                HStack {
                    Text("Length: ")
                        .font(.system(size: 20, weight: .bold))
                    Text(String(film.length) + " mins")
                }
                HStack {
                    Text("Formats: ")
                        .font(.system(size: 20, weight: .bold))
                    Text(getFormats().joined(separator: ", "))
                }
                HStack {
                    Text("Genres: ")
                        .font(.system(size: 20, weight: .bold))
                    Text(getGenre().joined(separator: ", "))
                }
                FilmDetailsBooking(cinemaEvents: cinemaEvents, cinemas: cinemas)
                Spacer()
                    .frame(
                        minHeight: 800,
                        maxHeight: .infinity
                    )
                    .background(colorscheme == .light ? .white : .black)
            }
            .padding(.horizontal)
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
            .background(colorscheme == .light ? .white : .black)
        }
    }
    
    private func getFormats() -> [String] {
        let useful = [
            "2d",
            "3d",
            "4dx",
            "imax",
            "dolby-atmos",
            "screenx"
        ]
        return film.attributeIds.filter { useful.contains($0) }
    }
    
    private func getGenre() -> [String] {
        let genre = [
            "animation",
            "family",
            "crime",
            "action",
            "sci-fi",
            "adventure",
            "thriller"
        ]
        let genre2 = [
            "drama",
            "mystery",
            "horror",
            "comedy",
            "adult"
        ]
        let genre3 = [
            "sport",
            "fantasy",
            "musical",
            "biography",
            "history",
            "romance"
        ]
        return film.attributeIds.filter { genre.contains($0) || genre2.contains($0) || genre3.contains($0) }
    }
}
