//
//  SettingTableViewCell.swift
//  TanksModeling
//
//  Created by Алексей on 11/11/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    static let identifier = "SettingTableViewCellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textLabel?.textColor = #colorLiteral(red: 0.7459739654, green: 0.7577740701, blue: 0.7198926508, alpha: 1)
        self.tintColor = #colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.2, alpha: 1)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
