//
//  ViewController.swift
//  FetchRewardsCodingChallenge
//
//  Created by Lyle Jover on 8/11/21.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var eventHandler: MealEventHandler?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
        eventHandler = MealEventHandler(delegate: self)
        eventHandler?.handle(.loadInitialData)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        title = "Recipes"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mealDetailSegue",
           let viewController = segue.destination as? DetailViewController,
           let meal = sender as? MealViewModel {
            viewController.meal = meal.meal
        }
    }
    
    //MARK: Private Methods
    private func configureTableview(){
        tableView.register(UINib(nibName: MealCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MealCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.delegate = self
        tableView.dataSource = self
    }

}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        eventHandler?.dataSource.numberOfSections() ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventHandler?.dataSource.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        eventHandler?.dataSource.cellForRowAt(tableView, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler?.handle(.didTapMeal(indexPath))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventHandler?.dataSource.categories[section].name
    }
}

//MARK: MealEventHandlerDelegate
extension ViewController: MealEventHandlerDelegate {
    func showDetail(for meal: MealViewModel) {
        performSegue(withIdentifier: "mealDetailSegue", sender: meal)
    }
    
    func didFinishLoadingData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}



