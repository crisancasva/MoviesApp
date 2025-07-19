//
//  TabBar.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 16/07/25.
//

import SwiftUI

struct TabBar: View {
    @State var text:String = ""
    var textFavorite: String
    var textHome: String
    private var iconFavorite: some View {
        Image(systemName: "star.fill")
        
    }
    private var iconHome: some View {
        Image(systemName: "square.split.2x2.fill")
        
    }
    
    var body: some View {
      
            
            TabView {
                PrimaryButton(title: text)
                    .tabItem {
                        iconHome
                        Text(textHome)
                    }
                Text("Pantalla de Favoritos")
                    .tabItem {
                        iconFavorite
                        Text(textFavorite)
                    }
                
                
            }
        
    }
}

#Preview {
    TabBar(textFavorite: "Favoritos", textHome: "Home")
}
