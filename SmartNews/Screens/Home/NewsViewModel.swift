//
//  NewsViewModel.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import Foundation

protocol NewsViewControllerDelegate {
    var newsArray: [Article] { get set }
    var businessArray: [Article] { get set }
    var entertainmentArray: [Article] { get set }
    var healthArray: [Article] { get set }
    var scienceArray: [Article] { get set }
    var sportsArray: [Article] { get set }
    var technologyArray: [Article] { get set }
    var categories: [SelectCategoryModel] { get set }
    var newsService: NewsService { get }
    var newsScreenOutput: NewsViewControllerOutput? { get }
    func setDelegate(output: NewsViewControllerOutput)
    func fetchNews()
    func getCategories()
}

final class NewsViewModel: NewsViewControllerDelegate {
    
    var categories: [SelectCategoryModel] = []
    var newsArray: [Article] = []
    var businessArray: [Article] = []
    var entertainmentArray: [Article] = []
    var healthArray: [Article] = []
    var scienceArray: [Article] = []
    var sportsArray: [Article] = []
    var technologyArray: [Article] = []
    var newsService: NewsService
    var newsScreenOutput: NewsViewControllerOutput?
    
    init() {
        newsService = NewsService()
    }
    
    func setDelegate(output: NewsViewControllerOutput) {
        newsScreenOutput = output
    }
        
    func fetchNews() {
        newsService.parseGeneralNews(category: "general") { [weak self] (completion) in
            self?.newsArray = completion ?? []
            self?.newsScreenOutput?.newsData(news: self?.newsArray ?? [])
        }
        newsService.parseGeneralNews(category: "business") { [weak self] (completion) in
            self?.businessArray = completion ?? []
            self?.newsScreenOutput?.businessData(news: self?.businessArray ?? [])
        }
        newsService.parseGeneralNews(category: "entertainment") { [weak self] (completion) in
            self?.entertainmentArray = completion ?? []
            self?.newsScreenOutput?.entertainmentData(news: self?.entertainmentArray ?? [])
        }
        newsService.parseGeneralNews(category: "health") { [weak self] (completion) in
            self?.healthArray = completion ?? []
            self?.newsScreenOutput?.healthData(news: self?.healthArray ?? [])
        }
        newsService.parseGeneralNews(category: "science") { [weak self] (completion) in
            self?.scienceArray = completion ?? []
            self?.newsScreenOutput?.scienceData(news: self?.scienceArray ?? [])
        }
        newsService.parseGeneralNews(category: "sports") { [weak self] (completion) in
            self?.sportsArray = completion ?? []
            self?.newsScreenOutput?.sportsData(news: self?.sportsArray ?? [])
        }
        newsService.parseGeneralNews(category: "technology") { [weak self] (completion) in
            self?.technologyArray = completion ?? []
            self?.newsScreenOutput?.technologyData(news: self?.technologyArray ?? [])
        }
    }
    
    func getCategories() {
        guard
            let data = UserDefaults.standard.data(forKey: "headings"),
            let savedCategories = try? JSONDecoder().decode([SelectCategoryModel].self, from: data)
        else { return }
        for item in savedCategories {
            if item.isFollow {
                self.categories.append(item)
            }
        }
    }
    
}
