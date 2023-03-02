//
//  NetworkManager.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import Foundation

final class NetworkManager {

    func getRandomRecipes(url: String, completion: @escaping(Result<[Recipes], Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }

            // String(data: data, encoding: .utf8).map { print($0) }

            do {
                let json = try JSONDecoder().decode(Recipe.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json.recipes))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
