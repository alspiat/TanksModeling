//
//  ArmamentViewController.swift
//  TanksModeling
//
//  Created by Aliaksei Piatyha on 11/13/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ArmamentViewController: UIViewController {

    @IBOutlet weak var armamentTableView: UITableView!
    
    var settingsModel: SettingsModel?
    var settingsKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        armamentTableView.delegate = self
        armamentTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToModeling",
            let modelingVC = segue.destination as? ModelingViewController {
            modelingVC.settingsModel = self.settingsModel
        } else if segue.identifier == "segueToArmamentB",
            let armamentBSettings = segue.destination as? ArmamentViewController {
            armamentBSettings.settingsModel = settingsModel
            armamentBSettings.title = "Сторона B"
            armamentBSettings.settingsKey = "Armament B"
        }
    }

}
