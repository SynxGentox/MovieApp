//
//  MovieDetailedView.swift
//  MovieApp
//
//  Created by Aryan Verma on 15/03/26.
//

import SwiftUI

struct MovieDetailedView: View {
    @Environment(MovieStore.self) private var store
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack {
                Image(movie.imageName)
                    .resizable()
                    .scaledToFit()
                    .background(.ultraThinMaterial)
                
                Text(movie.title)
                    .font(.system(size: 34, weight: .semibold, design: .serif))
                
                Text("\(movie.genre) · \(movie.releaseYear)")
                    .foregroundStyle(.secondary)
                
                Text("\(movie.rating.formatted()) ⭐️")
                
                Text(movie.description)
                    .padding()
                
                HStack(spacing: 24) {
                    Button { store.toggleLike(for: movie) } label: {
                        Image(systemName: store.isLiked(movie) ? "heart.fill" : "heart")
                            .foregroundStyle(store.isLiked(movie) ? .red : .secondary)
                            .font(.system(size: 28))
                    }
                    Button { store.toggleWatchLater(for: movie) } label: {
                        Image(systemName: store.isWatchLater(movie) ? "plus.app.fill" : "plus.app")
                            .foregroundStyle(store.isWatchLater(movie) ? .yellow : .secondary)
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
        }
    }
}

#Preview {
    MovieDetailedView(movie: MovieStore().movies[0])
        .environment(MovieStore())
}
