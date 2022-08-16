//
//  SelectCategoryViewModel.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import Foundation

class SelectCategoryViewModel {
    
    var items: [SelectCategoryModel] = [
                                     SelectCategoryModel(categoryName: "Business", isFollow: false),
                                     SelectCategoryModel(categoryName: "Entertainment", isFollow: false),
                                     SelectCategoryModel(categoryName: "Health", isFollow: false),
                                     SelectCategoryModel(categoryName: "Science", isFollow: false),
                                     SelectCategoryModel(categoryName: "Sports", isFollow: false),
                                     SelectCategoryModel(categoryName: "Technology", isFollow: false) ] {
        didSet {
            saveCategory()
        }
    }
    init() {
        getItems()
    }
    
    let baseCategories: [String] = ["Business", "Entertainment", "Health", "Science", "Sports", "Technology"]
    let letters: [String] = ["B", "E", "H", "Sc", "Sp", "T"]

    func updateCategory(item: SelectCategoryModel) {
        if let index = items.firstIndex(where: {$0.categoryName == item.categoryName}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveCategory() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: "headings")
        }
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: "headings"),
            let savedCategories = try? JSONDecoder().decode([SelectCategoryModel].self, from: data)
        else { return }
        
        self.items = savedCategories
    }
}
