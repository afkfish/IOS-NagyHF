//
//  FilmListView.swift
//  CinemaDB
//
//  Created by Beni Kis on 02/12/2023.
//

import SwiftUI

struct FilmListView: View {
    @Binding var films: [Film]
    
    @State private var searchText = ""
    
    private var filteredList: [Film] {
        if searchText.isEmpty {
            return films
        } else {
            return films.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        List(filteredList) {film in
            NavigationLink(destination: FilmDetailsView(film: film)) {
                Text(film.name)
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Films")
    }
}

#Preview {
    @State var films = [Film.dummy]
    return FilmListView(films: $films)
}
