//
//  Category.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import Foundation

struct Category: Decodable, Hashable {
    let id: String
    let name: String
    let imageURL: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case imageURL = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}
