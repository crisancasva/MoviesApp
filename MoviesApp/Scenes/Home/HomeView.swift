//
//  HomeView.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        TabBarViewApp(items: [
            TabBarViewApp.Item(view: AnyView(MovieView.buildWeb()), icon: Image(systemName: "square.grid.2x2.fill"), title: "Home"),
            TabBarViewApp.Item(view: AnyView(MovieView.buildDB()), icon: Image(systemName: "star.fill"), title: "Favoritos")
        ])
    }
}

extension HomeView {
    static func build() -> NavigatorScreen {
        let action = NavigatorActionButton(title: "Cerrar Sesion") {
            print("llamar el close")
        }
        let view = HomeView()
            .navigatorBarStyle(.titleBackAndAction("", action))
        return NavigatorScreen(view: view)
    }
}

