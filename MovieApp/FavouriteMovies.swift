//
//  FavouriteMovies.swift
//  MovieApp
//
//  Created by Aryan Verma on 15/03/26.
//

import SwiftUI

struct FavouriteMovies: View {
    @Environment(MovieStore.self) private var store
    var body: some View {
        VStack {
            Text("Favourites")
                .font(.system(size: 51, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .shadow(radius: 10)
                .padding(.horizontal)
                
            List(store.likedMovies) { movie in
                NavigationLink(destination: MovieDetailedView(movie: movie)) {
                    HStack {
                        MoviePoster(imageURL: movie.Poster)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .padding(.trailing)
                                
                        VStack(alignment: .leading) {
                            Text(movie.Title)
                                .font(.system(size: 20, weight: .regular))
                            Text(
                                "Sci-Fi,    Rating: 9/10 "
                            )
                            .font(.system(size: 14, weight: .regular))
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let store =  MovieStore()
    FavouriteMovies()
        .environment(store)
}
