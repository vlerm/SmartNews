//
//  NewsService.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import Foundation

struct NewsService {
    
    static let shared = NewsService()
    
    func parseGeneralNews(category: String, completion: @escaping ([Article]?) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)top-headlines?country=ru&category=\(category)&apiKey=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(Response.self, from: data)
                completion(jsonData.articles)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    func parseSearchingNews(query: String, completion: @escaping ([Article]?) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.BASE_URL)everything?q=\(query)&language=ru&apiKey=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(Response.self, from: data)
                completion(jsonData.articles)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
