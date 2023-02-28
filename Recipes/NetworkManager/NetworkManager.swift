//
//  NetworkManager.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()

    private let apiKey = "6905ee4becbd4e0b99cff161dd309083"
    static func getRandomRecipes() {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/716429/information?apiKey=6905ee4becbd4e0b99cff161dd309083&in/random") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            print(response)
            print(data)
        }.resume()

    }
}
