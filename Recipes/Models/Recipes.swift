//
//  Recipes.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import Foundation

struct Recipes: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let title: String
    let image: String
    let instructions: String
    let readyInMinutes: Int
}

struct Recipesss: Decodable {
    let results: [Resultss]
}

struct Resultss: Decodable {
    let title: String
    let image: String
}

