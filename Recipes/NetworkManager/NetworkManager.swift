//
//  NetworkManager.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import Foundation

final class NetworkManager {

    static func getRandomRecipes(url: String, completion: @escaping(Result<Recipes, Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            do {
                let json = try JSONDecoder().decode(Recipes.self, from: data)
                DispatchQueue.main.async {
                    print(json)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
