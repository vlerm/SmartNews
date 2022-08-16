//
//  SearchViewController.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit

protocol SearchViewControllerOutput {
    func searchingData(news: [Article])
}

class SearchViewController: UIViewController, UISearchBarDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    private var searchingList: [Article] = [Article]()
    
    lazy var viewModel: SearchViewModelDelegate = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        viewModel.setDelegate(output: self)
        viewModel.searchNews(query: "Russia")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
                self.viewModel.searchNews(query: searchText)
                self.searchTableView.reloadData()
        }
    }
}

extension SearchViewController: SearchViewControllerOutput {
    
    func searchingData(news: [Article]) {
        DispatchQueue.main.async {
            self.searchingList = news
            self.searchTableView.reloadData()
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.searchTitleLabel.text = searchingList[indexPath.row].title
        let imageUrl = searchingList[indexPath.row].urlToImage ?? "SmartLogo"
        cell.searchImageView.load(url: URL(string: imageUrl)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "searchToWebVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToWebVC" {
            guard let destinationVC = segue.destination as? WebViewController else { return }
            let indexPath = self.searchTableView.indexPathForSelectedRow
            guard let indexUrl = searchingList[(indexPath?.row)!].url else {return}
            destinationVC.stringURL = indexUrl
        }
    }
    
}
