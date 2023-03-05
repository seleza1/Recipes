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

    func getSearchRecipes(url: String, completion: @escaping(Result<[Resultss], NetworkError>) -> Void) {
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

    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }

        }.resume()
    }

    func getRandomRecipes(url: String, completion: @escaping(Result<[Recipe], NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.invalidURL))
                return
            }

            // String(data: data, encoding: .utf8).map { print($0) }

            do {
                let json = try JSONDecoder().decode(Recipes.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json.recipes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()

    }

}





func async(url: String) async throws -> [Resultss] { // throws error
    guard let url = URL(string: url) else {
        throw NetworkError.invalidURL
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    guard let json = try? JSONDecoder().decode(Recipesss.self, from: data) else {
        throw NetworkError.decodingError
    }

    return json.results

}
