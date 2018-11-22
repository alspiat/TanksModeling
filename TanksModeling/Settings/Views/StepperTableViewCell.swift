//
//  StepperTableViewCell.swift
//  TanksModeling
//
//  Created by Алексей on 11/12/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class StepperTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countStepper: UIStepper!
    
    var settingsModel: SettingsModel?
    var settingsKey = ""
    var settingHeader = ""
    
    static let identifier = "StepperTableViewCellIdentifier"
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        countLabel.text = Int(sender.value).description
        settingsModel?.armamentSettings[settingsKey]?[settingHeader]?[textLabel!.text!] = Int(sender.value)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textLabel?.textColor = #colorLiteral(red: 0.7459739654, green: 0.7577740701, blue: 0.7198926508, alpha: 1)
        self.countLabel.textColor = #colorLiteral(red: 0.7459739654, green: 0.7577740701, blue: 0.7198926508, alpha: 1)
        self.tintColor = #colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.2, alpha: 1)
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
