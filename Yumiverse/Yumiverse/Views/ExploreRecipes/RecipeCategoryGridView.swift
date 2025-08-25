//
//  RecipeCategoryGridView.swift
//  Yumiverse
//
//  Created by Izel on 8/21/25.
//
import SwiftUI

struct RecipeCategoryGridView: View {
    @StateObject private var recipeData = RecipeData()
    //each item must be at least 140
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140), spacing: 12)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        NavigationLink(destination: RecipesListView(category: category).environmentObject(recipeData),
                                       label: {
                            CategoryCard(title: category.rawValue.capitalized,
                                         imageName: category.rawValue)
                        })
                    }
                }
                .padding()
            }
            .navigationTitle("Categories")
        }
    }
}

//reusable card struct

struct CategoryCard: View {
    let title: String
    let imageName: String

    var body: some View {
        //align bottom-left
        ZStack(alignment: .bottomLeading) {
            //load image by name
            Image(imageName)
                .resizable()
                //fills the frame
                .scaledToFill()
                .frame(height: 160)
                //image doesn't overflow
                .clipped()
            
            //for transparent top/dark bottom effect
            LinearGradient(
                colors: [.black.opacity(0.0), .black.opacity(0.55)],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: 70)
            .frame(maxWidth: .infinity, alignment: .bottom)

            //category title
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.bottom, 10)
                .shadow(radius: 2)
        }
        
        //card styling - card size,rounded corners,
        .frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.black.opacity(0.06), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    RecipeCategoryGridView()
}

