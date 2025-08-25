//
//  ModifyRecipeView.swift
//  Yumiverse
//
//  Created by Izel on 8/25/25.
//

import SwiftUI

struct ModifyRecipeView: View {
    //RecipeListView will provide the recipe.
    //Binding allows to access and modify the original property as if it owned recipe.
    //It doesn't need to send any recipe data back to RecipesListView since it was already owned by RecipeListView
    
    @Binding var recipe: Recipe
    
    var body: some View {
        Button("Fill in the recipe with test data."){
            recipe.mainInformation = MainInformation(name:"test", description: "test", author:"test", category: .breakfast)
            recipe.directions = [Direction(description: "trst", isOptional: false)]
            recipe.ingredients = [Ingredient(name: "test", quantity: 0.0, unit: .none)]
        }
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
