//
//  ContentView.swift
//  iPokedex
//
//  Created by Michael Wijaya Sutrisna on 25/02/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var api = PokemonServerApi()
    @State var pokemonCount = 0
    @State var pokemonAddCount = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    VStack (alignment: .leading){
                        let totalPokemon = api.pokemonNames.count
                        
                        if totalPokemon > 0 {
                            let _ = print("Total Pokemon Count: \(pokemonCount)")
                            let _ = print("Total Pokemon Listed: \(totalPokemon)")
                            ForEach(0..<totalPokemon, id: \.self) { index in
                                Text("Pokemon Id: \(api.pokemonId[index])")
                                Text("Pokemon Name: \(api.pokemonNames[index].capitalized)")
                                Text("")
                            }
                            
                            Button {
                                pokemonAddCount = pokemonCount + 10
                            } label: {
                                Text("Load More Pokemon")
                            }
                            .onChange(of: pokemonAddCount){
                                for i in pokemonCount..<pokemonAddCount + 1 { // There are 1025 Pokemons
                                    api.getData(index: i)
                                }
                                pokemonCount = pokemonAddCount
                            }
                            
                        } else {
                            let _ = print("Total Pokemon Count: \(pokemonCount)")
                            let _ = print("Total Pokemon Listed: \(totalPokemon)")
                            
                            Text("No Pokemon Listed")
                                .foregroundStyle(.secondary)
                            Button {
                                pokemonCount += 10
                            } label: {
                                Text("Load Pokemon")
                            }
                            .onChange(of: pokemonCount){
                                for i in 1..<pokemonCount { // There are 1025 Pokemons
                                    api.getData(index: i)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Pokemon")
        }
    }
}

#Preview {
    ContentView()
}
