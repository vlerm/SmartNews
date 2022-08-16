//
//  SelectCategoryModel.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import Foundation

struct SelectCategoryModel: Codable {
    
    var categoryName: String = String()
    var isFollow: Bool = false

    func updateCompletion() -> SelectCategoryModel {
        return SelectCategoryModel(categoryName: categoryName, isFollow: !isFollow)
    }
    
}
