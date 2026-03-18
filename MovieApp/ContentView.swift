//
//  ContentView.swift
//  MovieApp
//
//  Created by Aryan Verma on 14/03/26.
//

import SwiftUI
import Observation

struct Movie: Identifiable, Hashable{
    let id: UUID = UUID()
    let title: String
    let description: String
    let imageName: String
    let rating: Double
    let genre: String
    let releaseYear: String
}

@Observable
class MovieStore {
    var movies: [Movie] = [
        Movie(
            title: "Inception",
            description: "A thief who enters dreams to steal secrets.",
            imageName: "inception",
            rating: 8.8,
            genre: "Sci-Fi",
            releaseYear: "2010"
        ),
        Movie(
            title: "The Dark Knight",
            description: "Batman faces Gotham's greatest threat.",
            imageName: "dark_knight",
            rating: 9.0,
            genre: "Action",
            releaseYear: "2008"
        ),
        Movie(
            title: "Interstellar",
            description: "A crew travels through a wormhole in space.",
            imageName: "interstellar",
            rating: 8.6,
            genre: "Sci-Fi",
            releaseYear: "2014"
        ),
        Movie(
            title: "Parasite",
            description: "A poor family schemes to infiltrate a rich one.",
            imageName: "parasite",
            rating: 8.5,
            genre: "Thriller",
            releaseYear: "2019"
        ),
        Movie(
            title: "The Godfather",
            description: "The aging patriarch of a crime dynasty.",
            imageName: "godfather",
            rating: 9.2,
            genre: "Drama",
            releaseYear: "1972"
        ),
        Movie(
            title: "Whiplash",
            description: "A student pushes his limits to be the best.",
            imageName: "whiplash",
            rating: 8.5,
            genre: "Drama",
            releaseYear: "2014"
        ),
        Movie(
            title: "Get Out",
            description: "A man uncovers a disturbing secret.",
            imageName: "get_out",
            rating: 7.7,
            genre: "Horror",
            releaseYear: "2017"
        ),
        Movie(
            title: "Dune",
            description: "A noble family controls the universe's resource.",
            imageName: "dune",
            rating: 8.0,
            genre: "Sci-Fi",
            releaseYear: "2021"
        ),
    ]
    
    // MARK: - State
    private(set) var likedIDs: Set<UUID> = []
    private(set) var watchLaterIDs: Set<UUID> = []

    // MARK: - Intent
    func toggleLike(for movie: Movie) {
        if likedIDs.contains(movie.id) {
            likedIDs.remove(movie.id)
        } else {
            likedIDs.insert(movie.id)
        }
    }

    func toggleWatchLater(for movie: Movie) {
        if watchLaterIDs.contains(movie.id) {
            watchLaterIDs.remove(movie.id)
        } else {
            watchLaterIDs.insert(movie.id)
        }
    }

    // MARK: - Queries
    func isLiked(_ movie: Movie) -> Bool {
        likedIDs.contains(movie.id)
    }

    func isWatchLater(_ movie: Movie) -> Bool {
        watchLaterIDs.contains(movie.id)
    }

    var likedMovies: [Movie] {
        movies.filter { likedIDs.contains($0.id) }
    }

    var watchLaterMovies: [Movie] {
        movies.filter { watchLaterIDs.contains($0.id) }
    }
}



struct ContentView: View {
    @Environment(
        MovieStore.self
    ) private var store  // pulls it out of environment
        
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primary.opacity(0).ignoresSafeArea(edges: .all)
                MeshGradient(
                    width: 3,
                    height: 4,
                    points: [
                        [0.0,0.0],[0.5,0.0],[1.0,0.0],[0.0,0.0],
                        [0.0,0.5],[0.5,0.5],[1.0,0.4],[2,0.6],
                        [2,1.0],[0.8,1.0],[10.0,1.0],[0.5,1.0]
                    ],
                    colors: [.yellow, .pink.opacity(0.6), .indigo.opacity(0.1),
                             .purple.opacity(0.5), .white,  .purple,
                             .indigo, .purple, .black,
                             .white, .yellow, .yellow]
                )
                .ignoresSafeArea(edges: .all)
                VStack {
                    ScrollView(showsIndicators: false) {
                        // your own custom title
                        Text("Movies-Store")
                            .font(.system(size: 51, weight: .semibold))
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .shadow(radius: 10)
                            .padding(.horizontal)
                        
                        // rest of content
                        MovieListSection()
                            .shadow(radius: 16)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("")
                            // empty — hides default title
                        }
                    }
                    
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: FavouriteMovies()) {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: WatchLaterView()) {
                        Image(systemName: "plus.app.fill")
                            .foregroundStyle(.yellow)
                    }
                }
            }
            
        }
    }
}

struct MovieListSection: View {
    @Environment(MovieStore.self) private var store
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150, maximum: 1000), spacing: nil),
        GridItem(.adaptive(minimum: 150, maximum: 1000), spacing: nil)
    ]
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8){
                    MovieCard(
                        titleSize: 44,
                        subTitleSize: 16,
                        subTitlePadding: 21,
                        buttonSize: 26,
                        buttonPadding: 8,
                        frameWidth: 369,
                        frameHeight: 492
                    )
                    .shadow(radius: 10)
                }
            }
            .padding(.bottom, 52)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8){
                    MovieCard(
                        titleSize: 27,
                        subTitleSize: 16,
                        subTitlePadding: 13,
                        buttonSize: 26,
                        buttonPadding: 8,
                        frameWidth: 228,
                        frameHeight: 304
                    )
                    .shadow(radius: 10)
                }
            }   .padding(.bottom, 32)
            
            LazyVGrid(columns: columns) {
                ForEach(store.movies) { movie in
                    NavigationLink(
                        destination: MovieDetailedView(movie: movie)
                    ) {
                        ZStack{
                            Image(movie.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                            VStack{
                                Spacer()
                                
                                Text(movie.title)
                                    .font(
                                        .system(
                                            size: 23,
                                            weight: .semibold,
                                            design: .serif
                                        )
                                    )
                                    .foregroundStyle(.primary)
                                HStack{
                                    Text(
                                        String(
                                            "\(movie.rating.formatted()) ⭐️"
                                        )
                                    )
                                }
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.yellow)
                                .padding(.bottom, 11)
                            }
                            .shadow(radius: 10)
                        }
                        .frame(width: 198, height:  263)
                        .background(.ultraThinMaterial)
                    }
                }
            }
        }
    }
}

struct MovieCard: View {
    @Environment(MovieStore.self) private var store
    let titleSize :          CGFloat
    let subTitleSize :       CGFloat
    let subTitlePadding :    CGFloat
    let buttonSize :         CGFloat
    let buttonPadding :      CGFloat
    let frameWidth :         CGFloat
    let frameHeight :        CGFloat
    
    var body: some View {
        ForEach(store.movies) { movie in
            NavigationLink(destination: MovieDetailedView(movie: movie)) {
                ZStack{
                    Image(movie.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                
                    VStack{
                        Spacer()
                        Text(movie.title)
                            .font(
                                .system(
                                    size: CGFloat(titleSize),
                                    weight: .semibold,
                                    design: .serif
                                )
                            )
                    
                        HStack{
                            Text("\(movie.genre),")
                            Text(
                                String(
                                    "Rating: \(movie.rating.formatted()) ⭐️"
                                )
                            )
                        }
                        .font(
                            .system(
                                size: CGFloat(subTitleSize),
                                weight: .semibold,
                                design: .serif
                            )
                        )
                        .foregroundStyle(.yellow)
                        .padding(.bottom, CGFloat(subTitlePadding))
                    }
                }
                .frame(width: CGFloat(frameWidth), height: CGFloat(frameHeight))
                .background(.ultraThinMaterial)
            
                .overlay(alignment: .topTrailing){
                    VStack {
                        Button{
                            store.toggleLike(for: movie)
                        } label: {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(
                                    store
                                        .isLiked(
                                            movie
                                        ) ? .red : .secondary
                                )
                                .font(
                                    .system(
                                        size: CGFloat(buttonSize),
                                        weight: .semibold
                                    )
                                )
                        }
                        .padding(CGFloat(buttonPadding))
                    
                        Button{
                            store.toggleWatchLater(for: movie)
                        
                        } label: {
                            Image(systemName: "plus.app.fill")
                                .foregroundStyle(
                                    store
                                        .isWatchLater(
                                            movie
                                        ) ? .yellow : .secondary
                                )
                                .font(
                                    .system(
                                        size: CGFloat(buttonSize),
                                        weight: .semibold
                                    )
                                )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(MovieStore())
}

