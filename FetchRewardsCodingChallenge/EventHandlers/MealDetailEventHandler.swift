//
//  MealDetailEventHandler.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import Foundation

protocol MealDetailEventHandlerDelegate: AnyObject {
    func didFetchMealDetail(meal: Meal)
}

class MealDetailEventHandler {
    //MARK: ENUMS
    enum MealEvent {
        case loadMealDetail(Meal)
    }
    
    //MARK: Public Properties
    weak var delegate: MealDetailEventHandlerDelegate?
    
    //MARK: Private Properties
    private let requestHandler: MealRequestHandlerType
    
    //MARK: Lifecycle
    init(requestHandler: MealRequestHandlerType = MealRequestHandler(),
         delegate: MealDetailEventHandlerDelegate? = nil) {
        self.requestHandler = requestHandler
        self.delegate = delegate
    }
    
    //MARK: Public Methods
    func handle(_ event: MealEvent) {
        switch event {
        case .loadMealDetail(let meal):
            fetchDetail(for: meal)
        }
    }
    
    //MARK: Private Methods
    private func fetchDetail(for meal: Meal) {
        requestHandler.fetchMealsDetails(for: meal) { result in
            switch result {
            case .success(let mealDetail):
                meal.detail = mealDetail
                self.delegate?.didFetchMealDetail(meal: meal)
            case .failure(_):
                print("Show failure ui alert. Fail silently for now.")
                return
            }
        }
    }
}
