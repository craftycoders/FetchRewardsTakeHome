//
//  MealEventHandler.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import Foundation

protocol MealEventHandlerDelegate: AnyObject {
    func didFinishLoadingData()
    func showDetail(for meal: MealViewModel)
}

class MealEventHandler {
    //MARK: ENUMS
    enum MealEvent {
        case loadInitialData
        case didTapMeal(IndexPath)
    }
    
    //MARK: Private Properties
    private let requestHandler: MealRequestHandlerType
    
    //MARK: Public Propeties
    weak var delegate: MealEventHandlerDelegate?
    var dataSource: MealDataSourceType
    
    //MARK: Lifecycle
    init(delegate: MealEventHandlerDelegate? = nil,
         dataSource: MealDataSourceType = MealDataSource(),
         requestHandler: MealRequestHandlerType = MealRequestHandler()) {
        self.requestHandler = requestHandler
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    //MARK: Public Methods
    func handle(_ event: MealEvent) {
        switch event {
        case .loadInitialData:
            fetchInitialData()
        case .didTapMeal(let indexPath):
            guard let meal = dataSource.mealViewModel(for: indexPath) else { return }
            delegate?.showDetail(for: meal)
        }
    }
    
    //MARK: Private Methods
    private func fetchInitialData() {
        requestHandler.fetchCategories { result in
            switch result {
            case .success(let categories):
                self.dataSource.categories = categories.sorted(by: {$0.name < $1.name})
                let dispatchGroup = DispatchGroup()
                for category in categories {
                    dispatchGroup.enter()
                    self.requestHandler.fetchMeals(for: category) { result in
                        switch result {
                        case .success(let meals):
                            self.dataSource.mealCategoryMap[category] = meals.sorted(by: {$0.name < $1.name}).map { MealViewModel($0) }
                        case .failure(_):
                            return
                        }
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .global()) {
                    self.delegate?.didFinishLoadingData()
                }
            case .failure(_):
                print("Show failure ui alert. Fail silently for now.")
                return
            }
        }
    }
    
}



