//
//  SettingsViewController.swift
//  TanksModeling
//
//  Created by Алексей on 11/11/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    var settingsDict: [String: [String: String]] = [
        "Ландшафт":
            ["Отсутствие растительности": "texture_desert",
             "Лес": "texture_forest",
             "Болото": "texture_swamp"],
        "Время суток":
            ["Ночь" : "0.7",
             "Вечер": "0.5",
             "День": "0.2",
             "Утро": "0"]
    ]
    
    var settingsModel = SettingsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToArmamentA",
            let armamentASettings = segue.destination as? ArmamentViewController {
            armamentASettings.settingsModel = settingsModel
            armamentASettings.title = "Сторона A"
            armamentASettings.settingsKey = "Armament A"
        }
    }
}
