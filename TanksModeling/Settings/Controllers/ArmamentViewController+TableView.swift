//
//  ArmamentViewController+TableView.swift
//  TanksModeling
//
//  Created by Aliaksei Piatyha on 11/13/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension ArmamentViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let armamentSettings = settingsModel?.armamentSettings[settingsKey] else {
            return 0
        }
        
        return armamentSettings.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let armamentSettings = settingsModel?.armamentSettings[settingsKey] else {
            return 0
        }
        
        let settingHeader = armamentSettings.keys.sorted()[section]
        
        return armamentSettings[settingHeader]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let armamentSettings = settingsModel?.armamentSettings[settingsKey] else {
            return nil
        }
        
        let settingHeader = armamentSettings.keys.sorted()[section]
        return settingHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StepperTableViewCell.identifier) as! StepperTableViewCell
        
        guard let armamentSettings = settingsModel?.armamentSettings[settingsKey] else {
            return cell
        }
        
        
        let settingHeader: String = armamentSettings.keys.sorted()[indexPath.section]
        
        if let settingTitle: String = armamentSettings[settingHeader]?.keys.sorted()[indexPath.row],
            let settingValue: Int = armamentSettings[settingHeader]?[settingTitle] {
            cell.textLabel?.text = settingTitle
            cell.countLabel.text = "\(settingValue)"
            cell.countStepper.value = Double(settingValue)
            
            cell.settingsModel = settingsModel
            cell.settingHeader = settingHeader
            cell.settingsKey = settingsKey
            
        }
        
        return cell
        
    }
}
