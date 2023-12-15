//
//  CinemaListView.swift
//  CinemaDB
//
//  Created by Beni Kis on 02/12/2023.
//

import SwiftUI

struct CinemaListView: View {
    @Binding var cinemas: [Cinema]
    
    @State private var searchText = ""
    private var filteredList: [Cinema] {
        if searchText.isEmpty {
            return cinemas
        } else {
            return cinemas.filter {
                $0.displayName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(filteredList) {cinema in
                    CinemaBoxView(cinema: cinema)
                }
                .searchable(text: $searchText)
                .navigationTitle("Cinemas")
            }
        }
    }
}

#Preview {
    @State var cinemas: [Cinema] = [Cinema.dummy]
    return CinemaListView(cinemas: $cinemas)
}
