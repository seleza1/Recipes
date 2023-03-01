//
//  Recipes.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import Foundation

struct Recipe: Decodable {
    let recipes: [Recipes]
}

// MARK: - Recipe
struct Recipes: Decodable {
    let title: String
    let image: String
}
