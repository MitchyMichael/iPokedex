//
//  PokemonDescriptionView.swift
//  iPokedex
//
//  Created by Michael Wijaya Sutrisna on 04/03/24.
//

import SwiftUI

struct PokemonDescriptionView: View {
    @State var pokemonName: String
    @State var pokemonImage: String
    @State var pokemonId: Int
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "\(pokemonImage)")) { phase in
                switch phase {
                case .empty:
                    // Placeholder view or activity indicator
                    ProgressView()
                case .success(let image):
                    // Actual image
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                    // Apply resizable to the image
                case .failure:
                    // Error placeholder or message
                    Text("Failed to load image")
                @unknown default:
                    // Handle unknown cases
                    EmptyView()
                }
            }
            
            HStack {
                VStack (alignment: .leading){
                    Text("Pokemon Id: \(pokemonId)")
                    Text("Pokemon Name: \(pokemonName)")
                    
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    PokemonDescriptionView(pokemonName: "", pokemonImage: "", pokemonId: 0)
}
