//
//  NewsViewController.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit

protocol NewsViewControllerOutput {
    
    func newsData(news: [Article])
    func businessData(news: [Article])
    func entertainmentData(news: [Article])
    func healthData(news: [Article])
    func scienceData(news: [Article])
    func sportsData(news: [Article])
    func technologyData(news: [Article])
}

final class NewsViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleCollectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!

    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    lazy var viewModel: NewsViewControllerDelegate = NewsViewModel()
    
    private var articleArray: [Article] = [Article]()
    private var businessArray: [Article] = [Article]()
    private var entertainmentArray: [Article] = [Article]()
    private var healthArray: [Article] = [Article]()
    private var scienceArray: [Article] = [Article]()
    private var sportArray: [Article] = [Article]()
    private var technologyArray: [Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        titleCollectionView.delegate = self
        titleCollectionView.dataSource = self
        self.viewModel.fetchNews()
        self.viewModel.getCategories()
        self.viewModel.setDelegate(output: self)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    @objc func categoriesTapped(_ sender: UIButton) {
        if sender.currentTitle == "Business" {
            articleArray = businessArray
            categoryLabel.text = "Business World"
            tableView.reloadData()
        } else if sender.currentTitle == "Entertainment" {
            articleArray = entertainmentArray
            categoryLabel.text = "Entertainment"
            tableView.reloadData()
        } else if sender.currentTitle == "Health" {
            articleArray = healthArray
            categoryLabel.text = "Health News"
            tableView.reloadData()
        } else if sender.currentTitle == "Science" {
            articleArray = scienceArray
            categoryLabel.text = "Science"
            tableView.reloadData()
        } else if sender.currentTitle == "Sports" {
            articleArray = sportArray
            categoryLabel.text = "Sports News"
            tableView.reloadData()
        } else if sender.currentTitle == "Technology" {
            articleArray = technologyArray
            categoryLabel.text = "Technology"
            tableView.reloadData()
        }
        UIView.animate(withDuration: 0.6,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.6) {
                sender.transform = CGAffineTransform.identity
            }
        })
    }
}

extension NewsViewController: NewsViewControllerOutput {
    
    func newsData(news: [Article]) {
        DispatchQueue.main.async {
            self.articleArray = news
            self.tableView.reloadData()
        }
    }
    
    func businessData(news: [Article]) {
        DispatchQueue.main.async {
            self.businessArray = news
            self.tableView.reloadData()
        }
    }
    
    func entertainmentData(news: [Article]) {
        DispatchQueue.main.async {
            self.entertainmentArray = news
            self.tableView.reloadData()
        }
    }
    
    func healthData(news: [Article]) {
        DispatchQueue.main.async {
            self.healthArray = news
            self.tableView.reloadData()
        }
    }
    
    func scienceData(news: [Article]) {
        DispatchQueue.main.async {
            self.scienceArray = news
            self.tableView.reloadData()
        }
    }
    
    func sportsData(news: [Article]) {
        DispatchQueue.main.async {
            self.sportArray = news
            self.tableView.reloadData()
        }
    }
    
    func technologyData(news: [Article]) {
        DispatchQueue.main.async {
            self.technologyArray = news
            self.tableView.reloadData()
        }
    }
    
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = titleCollectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as? NewsTitlesCollectionViewCell else { return UICollectionViewCell()}
        cell.titleButton.setTitle(viewModel.categories[indexPath.row].categoryName, for: UIControl.State.normal)
        cell.titleButton.backgroundColor = UIColor.systemBlue
        cell.titleButton.layer.cornerRadius = 10
        cell.titleButton.setTitleColor(.white, for: UIControl.State.normal)
        cell.titleButton.addTarget(self, action: #selector(categoriesTapped(_:)), for: UIControl.Event.touchUpInside)
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 106, height: 50)
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        cell.newsTitleLabel.text = articleArray[indexPath.row].title
        let imageUrl = articleArray[indexPath.row].urlToImage ?? "SmartLogo"
        cell.newsImageView.load(url: URL(string: imageUrl)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toWebVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebVC" {
            guard let destinationVC = segue.destination as? WebViewController else { return }
            let indexPath = self.tableView.indexPathForSelectedRow
            guard let indexUrl = articleArray[(indexPath?.row)!].url else {return}
            destinationVC.stringURL = indexUrl
        }
    }
    
}
