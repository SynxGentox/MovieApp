//
//  WatchLaterView.swift
//  MovieApp
//
//  Created by Aryan Verma on 16/03/26.
//

import SwiftUI

struct WatchLaterView: View {
    @Environment(MovieStore.self) private var store
    var body: some View {
        VStack {
            Text("Watch-Later")
                .font(.system(size: 51, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .shadow(radius: 10)
                .padding(.horizontal)
                
            List(store.watchLaterMovies) { movie in
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
                                "Hentai,    Rating: 6.9/10"
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
    WatchLaterView()
        .environment(MovieStore())
}
