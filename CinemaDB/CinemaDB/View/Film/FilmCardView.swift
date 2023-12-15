//
//  FilmCardView.swift
//  CinemaDB
//
//  Created by Beni Kis on 03/12/2023.
//

import SwiftUI

struct FilmCardView: View {
    @Environment(\.colorScheme) var colorscheme
    @State var film: Film
    
    var body: some View {
        NavigationLink(destination: FilmDetailsView(film: self.film)) {
            VStack {
                AsyncImage(url: URL(string: film.posterLink)!) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .gray, radius: 15)
                    .padding(.horizontal, 35)
//                Label(film.name, systemImage: "")
//                    .font(.system(size: 25, weight: .bold))
//                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    FilmCardView(film: Film.dummy)
}
