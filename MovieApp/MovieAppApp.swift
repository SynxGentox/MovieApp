//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Aryan Verma on 14/03/26.
//

import SwiftUI

@main
struct MovieAppApp: App {
    @State private var store = MovieStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}



