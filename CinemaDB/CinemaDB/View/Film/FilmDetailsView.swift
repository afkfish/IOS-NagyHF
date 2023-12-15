//
//  FilmDetailsView.swift
//  CinemaDB
//
//  Created by Beni Kis on 02/12/2023.
//

import SwiftUI
import Combine

struct FilmDetailsView: View {
    @Environment(\.colorScheme) var colorscheme
    
    @State var film: Film
    @State var cinemaEvents: [CinemaEvent] = []
    @State var cinemaIds: [String] = []
    @State var cinemas: [Cinema] = []
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CinemaData.displayName, ascending: true)],
        animation: .default
    )
    private var cinemaCoreData: FetchedResults<CinemaData>
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: film.posterLink)) {image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
                Spacer()
            }
            FilmDetailsScrollView(film: $film, cinemaEvents: cinemaEvents, cinemas: cinemas)
        }
        .onAppear {
            fetchPlayingCinemas()
            self.cinemas = Cinema.convert(from: cinemaCoreData.map {$0})
        }
        .onChange(of: cinemaIds) { old, new in
            new.forEach { id in
                fetchCinemaEvents(for: id)
            }
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    private func fetchCinemaEvents(for cinema: String) {
        let baseURL = "https://www.cinemacity.hu/hu/data-api-service/v1/quickbook/10102/film-events/in-cinema/\(cinema)/at-date/\(dateFormatter.string(from: Date()))"
        let url = URL(string: baseURL)!
        
        URLSession(configuration: .default)
            .dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(CinemaEventResponse.self, from: data)
                        DispatchQueue.main.async {
                            //print("Fetched cinema events!")
                            self.cinemaEvents.append(contentsOf: response.body.events.filter { $0.filmId == self.film.id })
                        }
                    } catch(let error) {
                        print(error)
                    }
                }
            }
        }.resume()
    }
    
    @State var groupCancellable: Cancellable?
    
    private func fetchPlayingCinemas() {
        let baseURL = "https://www.cinemacity.hu/hu/data-api-service/v1/quickbook/10102/groups/with-film/\(film.id)/until/\(dateFormatter.string(from: Date()))"
        let url = URL(string: baseURL)!
        
        self.groupCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: GroupsWithFilmResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    print("Fetched groups!")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { groups in
                var asd: [String] = []
                groups.body.groups.forEach {
                    asd.append(contentsOf: $0.cinemaIds)
                }
                self.cinemaIds = asd
            })
    }
}

#Preview {
    FilmDetailsView(film: Film.dummy)
}
