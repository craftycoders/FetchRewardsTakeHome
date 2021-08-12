//
//  MealDataSource.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import Foundation
import UIKit

protocol MealDataSourceType {    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func mealViewModel(for indexPath: IndexPath) -> MealViewModel?
    var categories: [Category] { get set }
    var mealCategoryMap: [Category: [MealViewModel]] { get set }
}

class MealDataSource: MealDataSourceType {
    //MARK: Public Properties
    var categories: [Category] = []
    var mealCategoryMap: [Category: [MealViewModel]] = [:]
    
    //MARK: Public Methods
    func numberOfSections() -> Int {
        return mealCategoryMap.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        let category = categories[section]
        return mealCategoryMap[category]?.count ?? 0
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.reuseIdentifier, for: indexPath) as! MealCell
        if let mealVM = mealViewModel(for: indexPath){
            cell.configure(for: mealVM)
            return cell
        }
        return UITableViewCell()
    }
    
    func mealViewModel(for indexPath: IndexPath) -> MealViewModel? {
        let category = categories[indexPath.section]
        let mealsInCategory = mealCategoryMap[category]
        guard let mealVM = mealsInCategory?[indexPath.row] else { return nil }
        return mealVM
    }
    
}
