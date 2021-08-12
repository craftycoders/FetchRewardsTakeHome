//
//  MealViewModel.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import Foundation

class MealViewModel {
    //MARK: Properties
    var name: String {
        return meal.name
    }
    
    var cookingInstructions: String {
        guard
            let cookingInstructions = meal.detail?.cookingInstructions,
            !cookingInstructions.isEmpty
        else {
            return "No cooking instructions available"
        }
        return cookingInstructions
    }
    
    var ingredients: [Ingredient] {
        return meal.detail?.ingredients ?? []
    }
    
    var meal: Meal
    
    //MARK: Lifecycle
    init(_ meal: Meal) {
        self.meal = meal
    }
}
