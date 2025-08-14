//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 14/07/25.
//

import SwiftUI

@main
struct MoviesAppApp: App {
   

    var body: some Scene {
            WindowGroup {
                ZStack {
                    NavigatorView(root: LoginView.build())
                    
                }
            }
        }
}
