# Movie Store

A SwiftUI movie browsing app with 
@Observable architecture and shared state.

## Features
- Browse movies in multiple layouts — 
  large cards, medium cards, and grid
- Like movies and save to Watch Later
- Full detail screen with movie info
- Favourites and Watch Later screens
  with live state sync across all views

## Architecture
- @Observable / MVVM
- Single source of truth via MovieStore
- Environment injection across view hierarchy
- Set<UUID> for O(1) liked/watchLater lookups

## Tech
- SwiftUI
- @Observable
- NavigationStack
- MeshGradient
- LazyVGrid
