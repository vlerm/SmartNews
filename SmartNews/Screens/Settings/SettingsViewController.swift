//
//  SettingsViewController.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    private let settings: [String] = ["Change categories"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let firstCell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as? FirstColumnTableViewCell else { return UITableViewCell()}
            firstCell.selectionStyle = .none
            firstCell.accessoryType = .disclosureIndicator
            firstCell.settingNameLabel.text = settings[indexPath.row]
            return firstCell
        } else {
            guard let secondCell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as? SecondColumnTableViewCell else { return UITableViewCell()}
            secondCell.selectionStyle = .none
            secondCell.settingNameLabel.text = "The Dark mode"
            return secondCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        switch selectedRow {
        case 0:
            performSegue(withIdentifier: "toTopics", sender: nil)
            break
        default:
            ()
        }
    }
    
}
