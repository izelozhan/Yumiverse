//
//  RecipeData.swift
//  Yumiverse
//
//  Created by Izel on 8/18/25.
//

import Foundation

//recipeData conforms to the observable object protocol, op monitors when the @published property changes 
class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
}
