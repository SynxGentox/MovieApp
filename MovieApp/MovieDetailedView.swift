//
//  MovieDetailedView.swift
//  MovieApp
//
//  Created by Aryan Verma on 15/03/26.
//

import SwiftUI

struct MovieDetailedView: View {
    @Environment(MovieStore.self) private var store
    let movie: MovieItems

    var body: some View {
        ScrollView(.vertical) {
                if store.status == .loading {
                    ProgressView()
                }
                else if store.status == .success {
                    MoviePoster(imageURL: movie.Poster)
                        .background(.ultraThinMaterial)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                
                    Text(movie.Title)
                        .font(
                            .system(size: 34, weight: .semibold, design: .serif)
                        )
                
                    Text("6.9/10 ⭐️")
                
                    Text("Hentai")
                        .padding()
                
                    HStack(spacing: 24) {
                        Button { store.toggleLike(for: movie) } label: {
                            Image(
                                systemName: store
                                    .isLiked(movie) ? "heart.fill" : "heart"
                            )
                            .foregroundStyle(
                                store.isLiked(movie) ? .red : .secondary
                            )
                            .font(.system(size: 28))
                        }
                        Button { store.toggleWatchLater(for: movie) } label: {
                            Image(
                                systemName: store
                                    .isWatchLater(
                                        movie
                                    ) ? "plus.app.fill" : "plus.app"
                            )
                            .foregroundStyle(
                                store.isWatchLater(movie) ? .yellow : .secondary
                            )
                            .font(.system(size: 28))
                        }
                        Button { } label: {
                            Image(systemName: "play.circle.fill")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 28))
                        }
                        .disabled(true)
                    }
                    .padding()
                }
                else {
                    VStack {
                        Image(systemName: "wifi.slash")
                        Text("Check your Wifi Connection!")
                    }
                }
            
        }
    }
}

#Preview {
    MovieDetailedView(
        movie: MovieItems(imdbID: "?", Title: "?", Poster: "?", Year: "")
    )
    .environment(MovieStore())
}
