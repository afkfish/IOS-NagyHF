//
//  FilmView.swift
//  CinemaDB
//
//  Created by Beni Kis on 03/12/2023.
//

import SwiftUI
import Combine

struct FilmView: View {
    @Environment(\.colorScheme) var colorscheme
    
    @Binding var films: [Film]
    
    @State private var layout = 1
    @State private var buttonImage = "list.bullet"
    
    var body: some View {
        NavigationView {
            VStack {
                if layout == 0 {
                    FilmListView(films: $films)
                } else {
                    TabView {
                        ForEach(films) {film in
                            FilmCardView(film: film)
                        }
                    }
                    .onAppear {
                        let appearance = UIPageControl.appearance()
                        appearance.currentPageIndicatorTintColor = colorscheme == .light ? .black : .white
                        appearance.pageIndicatorTintColor = colorscheme == .light ? UIColor.black.withAlphaComponent(0.2) : UIColor.white.withAlphaComponent(0.2)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.25)
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.bottom, 80)
                }
            }
            .navigationTitle("Films")
            .toolbar {
                ToolbarItem {
                    Button(action: layoutAction) {
                        Label("Change view", systemImage: buttonImage)
                    }
                }
            }
        }
    }
    
    private func layoutAction() {
        switch layout {
        case 0:
            buttonImage = "square.grid.2x2"
            layout = 1
        default:
            buttonImage = "list.bullet"
            layout = 0
        }
    }
}

#Preview {
    @State var films = [Film.dummy]
    return FilmView(films: $films)
}
