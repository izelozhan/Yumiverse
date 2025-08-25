//
//  ContentView.swift
//  Yumiverse
//
//  Created by Izel on 8/18/25.
//

import SwiftUI

struct RecipesListView: View {
//    @StateObject var recipeData = RecipeData()
    @EnvironmentObject private var recipeData: RecipeData
    let category: MainInformation.Category
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(navigationTitle)
                    .foregroundColor(AppColor.foreground)
                    .font(.title)
            }
        }

        
    }
}

extension RecipesListView {
    private var recipes: [Recipe] {
        recipeData.recipes(for: category)
    }
    
    private var navigationTitle: String {
        "\(category.rawValue.capitalized) Recipes"
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(category: .breakfast)
                .environmentObject(RecipeData())
        }
        }
}

