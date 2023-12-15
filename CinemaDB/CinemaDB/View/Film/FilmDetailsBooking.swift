//
//  FilmDetailsBooking.swift
//  CinemaDB
//
//  Created by Beni Kis on 07/12/2023.
//

import SwiftUI

struct FilmDetailsBooking: View {
    @State var cinemaEvents: [CinemaEvent]
    @State var cinemas: [Cinema]
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CinemaData.displayName, ascending: true)],
        animation: .default
    )
    private var cinemaCoreData: FetchedResults<CinemaData>
    
    @State var uniqueCinemas: [String] = []
    
    var body: some View {
        VStack {
            ForEach(uniqueCinemas, id: \.self) {cinemaId in
                VStack(alignment: .leading) {
                    Text(cinemas.first(where: {$0.id == cinemaId})?.displayName ?? "Missing cinema name")
                        .font(.system(size: 20, weight: .bold))
                    buttons
                }
                .padding(.top)
            }
        }
        .onAppear {
            getUniqueCinemas()
        }
    }
    
    var buttons: some View {
        return ForEach(cinemaEvents, id: \.id) {event in
            Text(timeFormatter.string(for: event.eventDateTime)!)
        }
    }
    
    private func getUniqueCinemas() {
        self.uniqueCinemas = Array(Set(cinemaEvents.map { $0.cinemaId }))
        print(uniqueCinemas)
    }
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter
    }()
}
