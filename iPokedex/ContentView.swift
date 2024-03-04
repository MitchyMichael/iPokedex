//
//  ContentView.swift
//  iPokedex
//
//  Created by Michael Wijaya Sutrisna on 25/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .onAppear(){
                for i in 1...5 { // Ada 1025 Pokemon
                    Api().getData(index: i)
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
