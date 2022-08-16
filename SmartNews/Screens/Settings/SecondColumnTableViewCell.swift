//
//  SecondColumnTableViewCell.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit

class SecondColumnTableViewCell: UITableViewCell {

    @IBOutlet weak var settingNameLabel: UILabel!
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        let appDelegate = UIApplication.shared.windows.first
        if sender.isOn {
            appDelegate?.overrideUserInterfaceStyle = .dark
            return
        }
        appDelegate?.overrideUserInterfaceStyle = .light
        return
    }
    
}
