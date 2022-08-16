//
//  SelectCategoriesViewController.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit

class SelectCategoriesViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    private let viewModel: SelectCategoryViewModel = SelectCategoryViewModel()
    
    private let colors: [UIColor] = [UIColor.systemGreen, UIColor.magenta, UIColor.red, UIColor.systemOrange, UIColor.purple, UIColor.systemBlue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        continueButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.viewModel.getItems()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
    @objc func addRemoveTapped(_ sender: UIButton!) {
        viewModel.updateCategory(item: viewModel.items[sender.tag])
        self.tableView.reloadData()
        continueButton.isEnabled = true
    }
    
}

extension SelectCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.baseCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SelectCategoryCell else { return UITableViewCell() }
        cell.categoryNameLabel.text = viewModel.baseCategories[indexPath.row]
        cell.firstLetterLabel.text = viewModel.letters[indexPath.row]
        cell.firstLetterLabel.backgroundColor = self.colors[indexPath.row % self.colors.count]
        cell.firstLetterLabel.layer.masksToBounds = true
        cell.firstLetterLabel.layer.cornerRadius = 25
        cell.addCategoryButton.tag = indexPath.row
        cell.addCategoryButton.addTarget(self,
                                       action: #selector(addRemoveTapped),
                                       for: UIControl.Event.touchUpInside)
        cell.addCategoryButton.tintColor = .white
        cell.addCategoryButton.layer.cornerRadius = 5
        if viewModel.items[indexPath.row].isFollow {
            cell.addCategoryButton.setTitle("Remove", for: UIControl.State.normal)
            cell.addCategoryButton.backgroundColor = .systemRed
        } else {
            cell.addCategoryButton.setTitle("Add", for: UIControl.State.normal)
            cell.addCategoryButton.backgroundColor = UIColor.systemBlue
        }
        return cell
    }
}
