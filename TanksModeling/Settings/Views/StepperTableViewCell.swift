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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
