//
//  TankView+CreatingModels.swift
//  TanksModeling
//
//  Created by Алексей on 11/23/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension TankView {
    static func tank(name: String, rate: Int, armorHealth: Int, armorPenetration: Int) -> TankView {
        let tank = TankView(image: UIImage(named: name))
        tank.rate = rate
        tank.armorHealth = armorHealth
        tank.armorPenetration = armorPenetration
        
        return tank
    }
    
    static var E100: TankView {
        return tank(name: "E-100", rate: 2, armorHealth: 25, armorPenetration: 5)
    }
    
    static var PanzerkampfwagenIV: TankView {
        return tank(name: "Panzerkampfwagen IV", rate: 5, armorHealth: 40, armorPenetration: 10)
    }
    
    static var PanzerkampfwagenIVG: TankView {
        return tank(name: "Panzerkampfwagen IV-G", rate: 5, armorHealth: 45, armorPenetration: 15)
    }
    
    static var VK3601: TankView {
        return tank(name: "VK3601", rate: 5, armorHealth: 30, armorPenetration: 7)
    }
    
    static var KV2: TankView {
        return tank(name: "KV-2", rate: 4, armorHealth: 35, armorPenetration: 9)
    }
    
    static var T34: TankView {
        return tank(name: "T-34", rate: 2, armorHealth: 30, armorPenetration: 8)
    }
    
    static var M6: TankView {
        return tank(name: "M-6", rate: 4, armorHealth: 35, armorPenetration: 10)
    }
    
    static var Tiger: TankView {
        return tank(name: "Tiger-II", rate: 5, armorHealth: 40, armorPenetration: 12)
    }
    
    
}
