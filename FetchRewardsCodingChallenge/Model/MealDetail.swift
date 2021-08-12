//
//  MealDetail.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import Foundation

class MealDetail: Decodable {
    var cookingInstructions: String = ""
    var ingredients: [Ingredient] = []
    
    private var strIngredient1: String = ""
    private var strIngredient2: String = ""
    private var strIngredient3: String = ""
    private var strIngredient4: String = ""
    private var strIngredient5: String = ""
    private var strIngredient6: String = ""
    private var strIngredient7: String = ""
    private var strIngredient8: String = ""
    private var strIngredient9: String = ""
    private var strIngredient10: String = ""
    private var strIngredient11: String = ""
    private var strIngredient12: String = ""
    private var strIngredient13: String = ""
    private var strIngredient14: String = ""
    private var strIngredient15: String = ""
    private var strIngredient16: String = ""
    private var strIngredient17: String = ""
    private var strIngredient18: String = ""
    private var strIngredient19: String = ""
    private var strIngredient20: String = ""
    private var strMeasure1: String = ""
    private var strMeasure2: String = ""
    private var strMeasure3: String = ""
    private var strMeasure4: String = ""
    private var strMeasure5: String = ""
    private var strMeasure6: String = ""
    private var strMeasure7: String = ""
    private var strMeasure8: String = ""
    private var strMeasure9: String = ""
    private var strMeasure10: String = ""
    private var strMeasure11: String = ""
    private var strMeasure12: String = ""
    private var strMeasure13: String = ""
    private var strMeasure14: String = ""
    private var strMeasure15: String = ""
    private var strMeasure16: String = ""
    private var strMeasure17: String = ""
    private var strMeasure18: String = ""
    private var strMeasure19: String = ""
    private var strMeasure20: String = ""
    
    enum CodingKeys: String, CodingKey {
        case cookingInstructions = "strInstructions"
    }
    
    enum IngredientCodingKeys: String, CodingKey, CaseIterable {
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
    }
    
    enum MeasureCodingKey: String, CodingKey, CaseIterable {
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cookingInstructions = try values.decodeIfPresent(String.self, forKey: .cookingInstructions) ?? ""
        let ingredientsNames = try decoder.container(keyedBy: IngredientCodingKeys.self)
        let measureAmounts = try decoder.container(keyedBy: MeasureCodingKey.self)
        for (index, key) in IngredientCodingKeys.allCases.enumerated() {
            guard let ingredientName = try ingredientsNames.decodeIfPresent(String.self, forKey: key) else { continue }
            if !ingredientName.isEmpty {
                let measure = try measureAmounts.decodeIfPresent(String.self, forKey: MeasureCodingKey.allCases[index]) ?? ""
                ingredients.append(Ingredient(name: ingredientName, measurement: measure))
            }
        }
    }
}

struct Ingredient {
    let name: String
    let measurement: String
}
