//
//  MealCell.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import UIKit

class MealCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: Properties
    static let reuseIdentifier = "MealCell"
    
    //MARK: Public Methods
    func configure(for meal: MealViewModel) {
        nameLabel.text = meal.name
    }
}
