//
//  CinemaBoxView.swift
//  CinemaDB
//
//  Created by Beni Kis on 04/12/2023.
//

import SwiftUI

struct CinemaBoxView: View {
    @State var cinema: Cinema
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: cinema.imageUrl)!) {image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .blur(radius: 5)
            .aspectRatio(contentMode: .fill)
            .frame(width: 350, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 25)
            
            Text(cinema.displayName)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
                .offset(y: -70)
                
            Button("", systemImage: "globe") {
                UIApplication.shared.open(URL(string: cinema.link)!)
            }
            .offset(x: -140, y: 70)
            .font(.system(size: 25))
            .foregroundStyle(.white)
            
            Button("", systemImage: "map") {
                let url = "http://maps.apple.com/maps?saddr=\(cinema.latitude),\(cinema.longitude)"
                UIApplication.shared.open(URL(string:url)!)
            }
            .offset(x: 140, y: 70)
            .font(.system(size: 25))
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    CinemaBoxView(cinema: Cinema.dummy)
}
