//
//  MealListView.swift
//  myMealsApp
//
//  Created by Yolanda Chigiji on 4/13/23.
//

import Foundation
import SwiftUI

struct MealListView: View {
    
    // Define a state property to hold the list of meals fetched from the API
    @State private var meals: [Meal] = []

    var body: some View {
        NavigationView {
            
            //create a list of meals
            List(meals) { meal in
                
                //navigation link to a detail for each meal
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(meal.strMeal)
                                .font(.headline)
                            Text("Tap to view recipe")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationBarTitle("Desserts")
            
            //call the function when the view appears
            .onAppear {
                fetchMeals()
            }
        }
    }

    //function for fetching the meals from the API
    func fetchMeals() {
        
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    
                    //decode the JSON response into a MealReasponse object
                    let decoder = JSONDecoder()
                    let mealResponse = try decoder.decode(MealResponse.self, from: data)
                    DispatchQueue.main.async {
                        meals = mealResponse.meals.sorted(by: { $0.strMeal < $1.strMeal })
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


