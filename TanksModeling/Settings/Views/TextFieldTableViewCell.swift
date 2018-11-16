//
//  TextFieldTableViewCell.swift
//  TanksModeling
//
//  Created by Алексей on 11/16/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countTextField: UITextField!
    
    static let identifier = "TextFieldTableViewCellIdentifier"

    var settingsModel: SettingsModel?
    var settingsKey = ""
    var settingHeader = ""
    
    
    @IBAction func countTextFieldDidChange(_ sender: UITextField) {
        settingsModel?.armamentSettings[settingsKey]?[settingHeader]?[textLabel!.text!] = Int(sender.text ?? "0")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
