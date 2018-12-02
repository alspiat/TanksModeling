//
//  SettingsModel.swift
//  TanksModeling
//
//  Created by Aliaksei Piatyha on 11/13/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

class SettingsModel {
    var armamentSettings = [
        "Armament A": [
            "Танки":
                ["T-34": 0,
                 "Tiger-II": 0,
                 "M-6": 0,
                 "E-100": 0,
                 "KV-2": 0,
                 "VK3601": 0,
                 "Panzerkampfwagen IV-G": 0,
                 "Panzerkampfwagen IV": 0],
            "Начальный рубеж":
                ["X": 10],
            "Конечный рубеж":
                ["X": 200]],
        "Armament B": [
            "Танки":
                ["T-34": 0,
                 "Tiger-II": 0,
                 "M-6": 0,
                 "E-100": 0,
                 "KV-2": 0,
                 "VK3601": 0,
                 "Panzerkampfwagen IV-G": 0,
                 "Panzerkampfwagen IV": 0],
            "Начальный рубеж":
                ["X": 700],
            "Конечный рубеж":
                ["X": 400]]
    ]
    
    var sceneSettings: [String: String] = [
        "Ландшафт": "texture_forest",
        "Время суток": "0.2"
    ]
}
