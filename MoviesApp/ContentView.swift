//
//  ContentView.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 14/07/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var text = ""
    var body: some View {
        VStack{
            TextTitle(text: "CineMikeCris")
            
            FollowTextField(text: $text).frame(maxWidth: .infinity).overlay(
                VStack {
                    HStack{
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.neutral200)
                    }
                    Spacer()
                    HStack{
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.neutral200)
                    }}
            )
            TabBar(textFavorite: "Favorite", textHome: "Peliculas")

        }
    }

    
}


#Preview {
    ContentView().padding()
}
