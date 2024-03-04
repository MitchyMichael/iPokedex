//
//  ContentView.swift
//  iPokedex
//
//  Created by Michael Wijaya Sutrisna on 25/02/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var api = PokemonServerApi()
    @State var pokemonCount = 10 // There are 1025 Pokemons
    @State var pokemonAddCount = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .brightness(-0.2)
                
                ScrollView {
                    HStack {
                        VStack (alignment: .leading){
                            let totalPokemon = api.pokemonNames.count
                            
                            if totalPokemon > 0 {
                                let _ = print("Total Pokemon Count: \(pokemonCount)")
                                let _ = print("Total Pokemon Listed: \(totalPokemon)")
                                
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 16) {
                                    ForEach(0..<totalPokemon, id: \.self) { index in
                                        NavigationLink(destination: PokemonDescriptionView(
                                            pokemonName: api.pokemonNames[index].capitalized,
                                            pokemonImage: api.pokemonImage[index], 
                                            pokemonId: api.pokemonId[index]), label: {
                                            VStack {
                                                AsyncImage(url: URL(string: "\(api.pokemonImage[index])")) { phase in
                                                    switch phase {
                                                    case .empty:
                                                        // Placeholder view or activity indicator
                                                        ProgressView()
                                                    case .success(let image):
                                                        // Actual image
                                                        image
                                                            .frame(height: 100)
                                                        // Apply resizable to the image
                                                    case .failure:
                                                        // Error placeholder or message
                                                        Text("Failed to load image")
                                                            .foregroundStyle(.red)
                                                            .padding(.bottom)
                                                    @unknown default:
                                                        // Handle unknown cases
                                                        EmptyView()
                                                    }
                                                }
                                                HStack {
                                                    Text("\(api.pokemonId[index]).")
                                                    Text("\(api.pokemonNames[index].capitalized)")
                                                        .lineLimit(1)
                                                }
                                                .foregroundStyle(.black)
                                                .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: 80, maxHeight: 180)
                                            .padding()
                                            .background(.white.opacity(0.6))
                                            .cornerRadius(5.0)
                                        })
                                        
                                    }
                                }
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button {
                                            pokemonAddCount = pokemonCount + 10
                                        } label: {
                                            Text("Load More Pokemon")
                                                .padding()
                                                .background(.blue)
                                                .cornerRadius(20)
                                                .foregroundStyle(.white)
                                            
                                        }
                                        .onChange(of: pokemonAddCount){
                                            for i in pokemonCount..<pokemonAddCount + 1 {
                                                api.getData(index: i)
                                            }
                                            pokemonCount = pokemonAddCount
                                        }
                                        Spacer()
                                    }
                                    .padding(.top)
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            pokemonAddCount = 1025
                                        } label: {
                                            Text("See All Pokemon")
                                                .padding()
                                                .background(.blue)
                                                .cornerRadius(20)
                                                .foregroundStyle(.white)
                                            
                                        }
                                        .onChange(of: pokemonAddCount){
                                            for i in pokemonCount..<pokemonAddCount + 1 {
                                                api.getData(index: i)
                                            }
                                            pokemonCount = pokemonAddCount
                                            
                                            if pokemonCount > 1025 {
                                                pokemonCount = 1025
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.top)
                                }
                                
                            } else {
                                Text("")
                                    .onAppear(){
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
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    ContentView()
}
