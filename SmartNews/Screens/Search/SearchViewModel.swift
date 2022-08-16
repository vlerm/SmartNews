//
//  SearchViewModel.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import Foundation

protocol SearchViewModelDelegate {
    
    var searchListArray: [Article] { get set }
    var newsService: NewsService { get }
    var searchScreenOutput: SearchViewControllerOutput? { get }
    
    func setDelegate(output: SearchViewControllerOutput)
    func searchNews(query: String)
}

class SearchViewModel: SearchViewModelDelegate {
    
    init() {
        newsService = NewsService()
    }
    
    var searchListArray: [Article] = []
    var newsService: NewsService
    var searchScreenOutput: SearchViewControllerOutput?
    
    func setDelegate(output: SearchViewControllerOutput) {
        searchScreenOutput = output
    }
        
    func searchNews(query: String) {
        newsService.parseSearchingNews(query: query) { [weak self] (completion) in
            self?.searchListArray = completion ?? []
            self?.searchScreenOutput?.searchingData(news: self?.searchListArray ?? [])
        }
    }
    
}
