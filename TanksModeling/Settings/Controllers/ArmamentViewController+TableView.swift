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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.337254902, green: 0.3333333333, blue: 0.2823529412, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = #colorLiteral(red: 0.7330647111, green: 0.7290506363, blue: 0.6879251003, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let armamentSettings = settingsModel?.armamentSettings[settingsKey] else {
            return UITableViewCell()
        }
        
        let settingHeader: String = armamentSettings.keys.sorted()[indexPath.section]
        
        if let settingTitle: String = armamentSettings[settingHeader]?.keys.sorted()[indexPath.row],
            let settingValue: Int = armamentSettings[settingHeader]?[settingTitle] {
            
            if settingHeader.contains("рубеж") {
                let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier) as! TextFieldTableViewCell
                
                cell.textLabel?.text = settingTitle
                cell.countTextField.text = "\(settingValue)"
                
                cell.settingsModel = settingsModel
                cell.settingHeader = settingHeader
                cell.settingsKey = settingsKey
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: StepperTableViewCell.identifier) as! StepperTableViewCell
                
                cell.textLabel?.text = settingTitle
                cell.countLabel.text = "\(settingValue)"
                cell.countStepper.value = Double(settingValue)
                
                cell.settingsModel = settingsModel
                cell.settingHeader = settingHeader
                cell.settingsKey = settingsKey
                
                return cell
            }
            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
