//
//  Meal.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import Foundation

class Meal: Decodable {
    let id: String
    let name: String
    var detail: MealDetail?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
    }
}
