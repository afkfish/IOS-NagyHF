//
//  MapView.swift
//  CinemaDB
//
//  Created by Beni Kis on 02/12/2023.
//

import SwiftUI
import MapKit

struct MapCinemaView: View {
    @Binding var cinemas: [Cinema]
    
    @State var selectedMarker: String?
    
    var body: some View {
        Map(selection: $selectedMarker) {
            UserAnnotation()
            ForEach(cinemas) { cinema in
                let location = CLLocationCoordinate2DMake(cinema.latitude, cinema.longitude)
                Marker(cinema.displayName, systemImage: "videoprojector", coordinate: location)
                    .tint(.red)
                    .tag(cinema.displayName)
            }
        }
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
    }
}

#Preview {
    @State var cinemas: [Cinema] = [Cinema.dummy]
    return MapCinemaView(cinemas: $cinemas)
}
