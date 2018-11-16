//
//  SettingsViewController+TableView.swift
//  TanksModeling
//
//  Created by Алексей on 11/11/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let settingHeader = settingsDict.keys.sorted()[section]
        return settingsDict[settingHeader]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let settingHeader = settingsDict.keys.sorted()[section]
        return settingHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingHeader = settingsDict.keys.sorted()[indexPath.section]
        let settingTitle = settingsDict[settingHeader]?.keys.sorted()[indexPath.row]
        let settingValue = settingsDict[settingHeader]![settingTitle!]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        cell.accessoryType = settingsModel.sceneSettings[settingHeader] == settingValue ? .checkmark : .none
        cell.textLabel?.text = settingTitle
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let settingHeader = settingsDict.keys.sorted()[indexPath.section]
        
        let settingTitle = settingsDict[settingHeader]?.keys.sorted()[indexPath.row]
        let settingValue = settingsDict[settingHeader]![settingTitle!]
        
        settingsModel.sceneSettings[settingHeader] = settingValue
        
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
