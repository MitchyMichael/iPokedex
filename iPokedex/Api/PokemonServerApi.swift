//
//  Pokedex.swift
//  iPokedex
//
//  Created by Michael Wijaya Sutrisna on 25/02/24.
//

import Foundation
import Alamofire

class Api: ObservableObject {
    func getData(index: Int){
        AF.request("https://pokeapi.co/api/v2/pokemon/\(index)", method: .get).responseData { response in
            print(response)
            
            switch response.result {
            case .success(let success):
                print("Disini \(success)")
                guard let decodedData = try? JSONDecoder().decode(PokemonResponse.self, from: success) else {
                    print("Failed to retrieve data")
                    return
                }
                print(decodedData)
            case .failure (let failure):
                print(failure)
                return
            }
        }
    }
}
