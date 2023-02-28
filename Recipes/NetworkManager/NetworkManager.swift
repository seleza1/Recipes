//
//  NetworkManager.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import Foundation

 class NetworkManager {

     func getRandomRecipes(url: String, completion: @escaping(Result<Recipes, Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }

            String(data: data, encoding: .utf8).map { print($0) }

            do {
                let json = try JSONDecoder().decode(Recipes.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json))
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
