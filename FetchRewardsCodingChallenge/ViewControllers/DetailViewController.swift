//
//  DetailViewController.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import UIKit
import MBProgressHUD

class DetailViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cookingInstructionsLabel: UILabel!
    @IBOutlet weak var ingredientsStackView: UIStackView!
    @IBOutlet weak var ingredientsTitleLabel: UILabel!
    
    //MARK: Properties
    var eventHandler: MealDetailEventHandler?
    var meal: Meal?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler = MealDetailEventHandler(delegate: self)
        ingredientsTitleLabel.isHidden = true
        guard let meal = meal else { return }
        eventHandler?.handle(.loadMealDetail(meal))
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func configureView(for meal: MealViewModel) {
        titleLabel.text = meal.name
        cookingInstructionsLabel.text = meal.cookingInstructions
        for ingredient in meal.ingredients {
            let ingredientLabel = UILabel()
            ingredientLabel.numberOfLines = 0
            ingredientLabel.text = "\(ingredient.measurement) - \(ingredient.name)"
            ingredientsStackView.addArrangedSubview(ingredientLabel)
        }
        ingredientsTitleLabel.isHidden = false
    }
}

extension DetailViewController: MealDetailEventHandlerDelegate {
    func didFetchMealDetail(meal: Meal) {
        let mealViewModel = MealViewModel(meal)
        configureView(for: mealViewModel)
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
