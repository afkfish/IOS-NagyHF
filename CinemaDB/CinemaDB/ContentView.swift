//
//  ContentView.swift
//  CinemaDB
//
//  Created by Beni Kis on 29/11/2023.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var films: [Film] = []
    @State private var cinemas: [Cinema] = []
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FilmData.name, ascending: true)],
        animation: .default)
    private var filmCoreData: FetchedResults<FilmData>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CinemaData.displayName, ascending: true)],
        animation: .default
    )
    private var cinemaCoreData: FetchedResults<CinemaData>
    
    var body: some View {
        TabView {
            FilmView(films: $films)
                .tabItem {
                    Image(systemName: "list.and.film")
                    Text("Films")
                }
            CinemaListView(cinemas: $cinemas)
                .tabItem {
                    Image(systemName: "videoprojector")
                    Text("Cinemas")
                }
            MapCinemaView(cinemas: $cinemas)
                .tabItem {
                    Image(systemName: "map")
                    Text("Maps")
                }
        }
        .onAppear{
            loadFilms()
            loadCinemas()
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private func loadFilms() {
        if (filmCoreData.first?.dateCreated ?? .distantPast) < Date().advanced(by: -23*60*60) {
            fetchFilms()
        } else {
            self.films = Film.convert(from: filmCoreData.map {$0})
        }
    }
    
    @State var filmCancellable: Cancellable?
    
    private func fetchFilms() {
        let baseURL = "https://www.cinemacity.hu/hu/data-api-service/v1/quickbook/10102/films/until/"
        let url = URL(string: baseURL + dateFormatter.string(from: Date()))!
        
        self.filmCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: FilmResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetched films!")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { filmResponse in
                self.films = filmResponse.body.films
                self.films.forEach {film in
                    _ = FilmData(from: film, context: viewContext)
                }
                do {
                    try viewContext.save()
                    print("Saved films!")
                } catch(let error) {
                    print(error.localizedDescription)
                }
            })
    }
    
    private func loadCinemas() {
        if (cinemaCoreData.first?.dateCreated ?? .distantPast) < Date().advanced(by: -30*24*60*60) {
            fetchCinemas()
        } else {
            self.cinemas = Cinema.convert(from: cinemaCoreData.map {$0})
        }
    }
    
    @State var cinemaCancellable: Cancellable?
    
    private func fetchCinemas() {
        let baseURL = "https://www.cinemacity.hu/hu/data-api-service/v1/quickbook/10102/cinemas/with-event/until/"
        let url = URL(string: baseURL + dateFormatter.string(from: Date()))!
        
        self.cinemaCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: CinemaResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetched cinemas!")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { cinemaResponse in
                self.cinemas = cinemaResponse.body.cinemas
                self.cinemas.forEach {cinema in
                    _ = CinemaData(from: cinema, context: viewContext)
                }
                do {
                    try viewContext.save()
                    print("Saved cinemas!")
                } catch(let error) {
                    print(error.localizedDescription)
                }
            })
    }
}
