//
//  NetworkManager.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {

    func getRandomRecipes(url: String, completion: @escaping(Result<[Resultss], NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.invalidURL))
                return
            }
            
            // String(data: data, encoding: .utf8).map { print($0) }
            
            do {
                let json = try JSONDecoder().decode(Recipesss.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json.results))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }

    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
