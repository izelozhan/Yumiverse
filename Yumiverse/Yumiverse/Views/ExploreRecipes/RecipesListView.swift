//
//  ContentView.swift
//  Yumiverse
//
//  Created by Izel on 8/18/25.
//

import SwiftUI

struct RecipesListView: View {
//  @StateObject var recipeData = RecipeData()
    @EnvironmentObject private var recipeData: RecipeData
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()

    let category: MainInformation.Category
    
//  COLORS
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }.navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text(navigationTitle)
                        .font(.title2.weight(.semibold))
                        .foregroundColor(AppColor.foreground)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresenting = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        //sheet is created to display modify-recipe-view
            .sheet(isPresented: $isPresenting, content: {
                NavigationView {
                    ModifyRecipeView(recipe: $newRecipe)
                        .toolbar(content: {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresenting = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction){
                                if newRecipe.isValid {
                                    Button("Add"){
                                        recipeData.add(recipe: newRecipe)
                                        isPresenting = false
                                    }
                                }
                            }
                        })
                        .navigationTitle("Add a New Recipe")
                }
            })
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

