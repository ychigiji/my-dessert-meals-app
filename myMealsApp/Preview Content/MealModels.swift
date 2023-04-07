//
//  MealModels.swift
//  myMealsApp
//
//  Created by Yolanda Chigiji on 4/13/23.
//

import Foundation
import SwiftUI


// A struct representing a meal item in the API response
struct Meal: Codable, Identifiable {
    let idMeal: String //ID of meal
    let strMeal: String //name of meal
    let strMealThumb: String // url of image of meal

    var id: String {
        return idMeal
    }
}

struct MealDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let strIngredients: [String]

    //Define the coding keys for decoding the JSON response
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strMealThumb, strInstructions
        
        //Define the keys for the ingredients and measurements arrays,
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the basic properties of the meal
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)

        var ingredients: [String] = []
        var measures: [String] = []
        
        //api returns upto 20 ingredients per meal
        // Loop through the 20 possible ingredients and measures
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measureKey = "strMeasure\(i)"
            
            // Use the ingredient and measure keys to decode the values for this index
            if let ingredientCodingKey = CodingKeys(stringValue: ingredientKey),
               let measureCodingKey = CodingKeys(stringValue: measureKey) {
                
                // Decode the values if they exist
                let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientCodingKey)
                let measure = try container.decodeIfPresent(String.self, forKey: measureCodingKey)

                // Append the ingredient and measure to their respective arrays if they are not nil or empty
                if let ingredient = ingredient, !ingredient.isEmpty {
                    ingredients.append(ingredient)
                }
                if let measure = measure, !measure.isEmpty {
                                   measures.append(measure)
                               }
            }
        }
        
        // Combine the ingredients and measures into a single string and assign to strIngredients
        strIngredients = zip(ingredients, measures).map { "\($0.0) (\($0.1))" }
    }
}

struct MealResponse: Codable {
    let meals: [Meal]
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
