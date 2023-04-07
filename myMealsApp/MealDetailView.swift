//
//  MealDetailView.swift
//  myMealsApp
//
//  Created by Yolanda Chigiji on 4/13/23.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    
    let mealId: String
    @State private var mealDetail: MealDetail?

    var body: some View {
        if let mealDetail = mealDetail {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    URLImage(urlString: mealDetail.strMealThumb)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(mealDetail.strMeal)
                            .font(.title.bold())

                        Text("Ingredients")
                            .font(.headline).padding(.top, 12)

                        VStack(alignment: .leading, spacing: 4) {
                                                    ForEach(mealDetail.strIngredients, id: \.self) { ingredient in
                                                        Text(ingredient)
                                                    }
                                                }

                        Text("Instructions")
                            .font(.headline).padding(.top, 12)

                        Text(mealDetail.strInstructions)
                           
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                fetchMealDetail()
            }
        } else {
            Text("Loading...")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    fetchMealDetail()
                }
        }
    }

    //function to fetch the meal detail view
    func fetchMealDetail() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let mealDetailResponse = try decoder.decode(MealDetailResponse.self, from: data)
                    DispatchQueue.main.async {
                        mealDetail = mealDetailResponse.meals.first
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
