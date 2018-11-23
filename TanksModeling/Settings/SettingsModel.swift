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
                ["T-34": 1,
                 "Tiger-II": 1,
                 "M-6": 1,
                 "E-100": 1,
                 "KV-2": 1,
                 "VK3601": 1,
                 "Panzerkampfwagen IV-G": 1,
                 "Panzerkampfwagen IV": 1],
            "Начальный рубеж":
                ["X": 10],
            "Конечный рубеж":
                ["X": 200]],
        "Armament B": [
            "Танки":
                ["T-34": 1,
                 "Tiger-II": 1,
                 "M-6": 1,
                 "E-100": 1,
                 "KV-2": 1,
                 "VK3601": 1,
                 "Panzerkampfwagen IV-G": 1,
                 "Panzerkampfwagen IV": 1],
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
