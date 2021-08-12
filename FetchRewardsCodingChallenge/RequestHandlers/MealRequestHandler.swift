//
//  MealRequestHandler.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import Foundation
import Alamofire

protocol MealRequestHandlerType {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void)
    func fetchMeals(for category: Category, completion: @escaping (Result<[Meal], Error>) -> Void)
    func fetchMealsDetails(for meal: Meal, completion: @escaping (Result<MealDetail, Error>) -> Void)
}

class MealRequestHandler: MealRequestHandlerType {
    //MARK: ENUMS
    private enum Configuration {
        static let categoryURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        static let mealURL = "https://www.themealdb.com/api/json/v1/1/filter.php"
        static let mealDetailsURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    }
    
    //MARK: Public Methods
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        AF.request(Configuration.categoryURL, method: .get, parameters: nil).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data
                else {
                    completion(.failure(RequestError.emptyResponse))
                    return
                }
                do {
                    let categories = try JSONDecoder().decode(CategoryResponse.self, from: data)
                    completion(.success(categories.categories))
                } catch {
                    completion(.failure(RequestError.parsingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMeals(for category: Category, completion: @escaping (Result<[Meal], Error>) -> Void) {
        let parameters: Parameters = ["c": category.name]
        AF.request(Configuration.mealURL, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data
                else {
                    completion(.failure(RequestError.emptyResponse))
                    return
                }
                do {
                    let meals = try JSONDecoder().decode(MealResponse.self, from: data)
                    completion(.success(meals.meals))
                } catch {
                    completion(.failure(RequestError.parsingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMealsDetails(for meal: Meal, completion: @escaping (Result<MealDetail, Error>) -> Void) {
        let parameters: Parameters = ["i": meal.id]
        AF.request(Configuration.mealDetailsURL, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data
                else {
                    completion(.failure(RequestError.emptyResponse))
                    return
                }
                do {
                    let meals = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
                    guard let mealDetail = meals.meals.first
                    else {
                        completion(.failure(RequestError.emptyResponse))
                        return
                    }
                    completion(.success(mealDetail))
                } catch {
                    completion(.failure(RequestError.parsingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension MealRequestHandler {
    private struct CategoryResponse: Decodable {
        let categories: [Category]
    }
    
    private struct MealResponse: Decodable {
        let meals: [Meal]
    }
    
    private struct MealDetailsResponse: Decodable {
        let meals: [MealDetail]
    }
}



