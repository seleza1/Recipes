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

// поправить нейминг

// MARK: - Recipe
struct Recipes: Decodable {
    let title: String
    let image: String
    let instructions: String
    let readyInMinutes: Int
}

