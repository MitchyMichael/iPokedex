//
//  PokemonResponse.swift
//  iPokedex
//
//  Created by Michael Wijaya Sutrisna on 04/03/24.
//

import Foundation

struct PokemonResponse: Codable {
    let id = UUID()
    let name: String
}
