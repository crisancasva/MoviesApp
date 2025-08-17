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
            TabBarViewApp.Item(view: AnyView(MovieListView.build()), icon: Image(systemName: "list.bullet"), title: "Home"),
            TabBarViewApp.Item(view: AnyView(DetailView.buildMock(999)), icon: Image(systemName: "richtext.page.fill"), title: "Favoritos")
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

