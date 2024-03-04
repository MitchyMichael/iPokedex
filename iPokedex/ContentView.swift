//
//  ContentView.swift
//  iPokedex
//
//  Created by Michael Wijaya Sutrisna on 25/02/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var api = PokemonServerApi()
    @State var pokemonCount = 10
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    VStack (alignment: .leading){
                        let totalPokemon = api.pokemonNames.count
                        let _ = print("Total Pokemon Listed: \(totalPokemon)")
                        
                        
                        ForEach(0..<totalPokemon, id: \.self) { index in
                            Text("Pokemon Name: \(api.pokemonNames[index].capitalized)")
                        }
                    }
                    Spacer()
                }
                .padding()
                .onAppear(){
                    for i in 1..<pokemonCount + 1 { // There are 1025 Pokemons
                        api.getData(index: i)
                    }
                }
            }
            .navigationTitle("Pokemon")
        }
        
        
    }
}

#Preview {
    ContentView()
}
