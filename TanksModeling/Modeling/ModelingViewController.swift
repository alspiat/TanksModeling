//
//  ModelingViewController.swift
//  TanksModeling
//
//  Created by Алексей on 11/11/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ModelingViewController: UIViewController {

    @IBOutlet weak var sceneScrollView: UIScrollView!
    @IBOutlet weak var sceneBackgroundView: UIImageView!
    @IBOutlet weak var sceneLightView: UIView!
    
    @IBOutlet weak var sceneHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sceneWidthConstraint: NSLayoutConstraint!
    
    var settingsModel: SettingsModel?
    
    var tanksA = [TankView]()
    var tanksB = [TankView]()
    
    var startPointA: CGFloat = 0
    var endPointA: CGFloat = 0
    var startPointB: CGFloat = 0
    var endPointB: CGFloat = 0
    
    let shootCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tanksASetting = settingsModel?.armamentSettings["Armament A"]?["Танки"],
            let tanksBSetting = settingsModel?.armamentSettings["Armament B"]?["Танки"],
            let settings = settingsModel?.sceneSettings,
            let startPointA = settingsModel?.armamentSettings["Armament A"]?["Начальный рубеж"]?["X"],
            let endPointA = settingsModel?.armamentSettings["Armament A"]?["Конечный рубеж"]?["X"],
            let startPointB = settingsModel?.armamentSettings["Armament B"]?["Начальный рубеж"]?["X"],
            let endPointB = settingsModel?.armamentSettings["Armament B"]?["Конечный рубеж"]?["X"] {
            
            self.configure(tanks: &tanksA, with: tanksASetting)
            self.configure(tanks: &tanksB, with: tanksBSetting)
            
            self.startPointA = CGFloat(startPointA)
            self.startPointB = CGFloat(startPointB)
            self.endPointA = CGFloat(endPointA)
            self.endPointB = CGFloat(endPointB)
        
            self.configureScene(settings: settings)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        for tank in self.tanksA {
            tank.move(view: tank, to: abs(startPointA - endPointA), animated: true)
            
            for i in 0..<shootCount {
                let timeout = DispatchTimeInterval.milliseconds(Int(arc4random_uniform(1000) + 500) * (i + 1))
                DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                    tank.shoot(animated: true, tanks: self.tanksB)
                }
            }
        }

        for tank in self.tanksB {
            tank.move(view: tank, to: -abs(startPointB - endPointB), animated: true)
            
            for i in 0..<shootCount {
                let timeout = DispatchTimeInterval.milliseconds(Int(arc4random_uniform(1000) + 500) * (i + 1))
                DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                    tank.shoot(animated: true, tanks: self.tanksA)
                }
            }
        }
    }
    
    @IBAction func shootButton(_ sender: UIBarButtonItem) {
        tanksA[0].shoot(animated: true, tanks: tanksB)
    }
    
    func configure(tanks: inout [TankView], with settings: [String: Int]) {
        for (key, value) in settings {
            
            var tankName: String
            var tankHP: Int
            var tankRate: Int
           // var tankShotPower: Double
           // var tankReloadTime: Double
            
            switch key {
            case "T-34":
                tankName = "T-34"
                tankHP = 3
                tankRate = 1
            case "Tiger-II":
                tankName = "Tiger-II"
                tankHP = 4
                tankRate = 2
            case "M-6":
                tankName = "M-6"
                tankHP = 1
                tankRate = 3
            case "E-100":
                tankName = "E-100"
                tankHP = 5
                tankRate = 4
            case "KV-2":
                tankName = "KV-2"
                tankHP = 2
                tankRate = 5
            case "VK3601":
                tankName = "VK3601"
                tankHP = 2
                tankRate = 6
            case "Panzerkampfwagen IV-G":
                tankName = "Panzerkampfwagen IV-G"
                tankHP = 3
                tankRate = 7
            case "Panzerkampfwagen IV":
                tankName = "Panzerkampfwagen IV"
                tankHP = 4
                tankRate = 8
            default:
                continue
            }
            
            for _ in 0..<value {
                let tank = TankView(image: UIImage(named: tankName))
                tank.tankHP = tankHP
                tank.tankRate = tankRate
                tanks.append(tank)
            }
        }
    }

    func configureScene(settings: [String: String]) {
        
        let sceneWidth = max(endPointA, startPointB) + 200
        
        if sceneWidth > sceneScrollView.bounds.width {
            sceneWidthConstraint.constant = sceneWidth - sceneScrollView.bounds.width
        }
        
        if let landscape = settings["Ландшафт"] {
            sceneBackgroundView.image = UIImage(named: landscape)
        }

        if let darkness = settings["Время суток"],
            let darknessValue = Double(darkness) {
            sceneLightView.alpha = CGFloat(darknessValue)
        }

        let offset: CGFloat = 20
        
        var y: CGFloat = offset
        var x: CGFloat = startPointA
        
        var contentSizeA: CGFloat = 0
        var contentSizeB: CGFloat = 0

        for tank in tanksA {
            sceneScrollView.addSubview(tank)
            tank.frame.origin.x = x
            tank.frame.origin.y = y

            y += offset + tank.frame.size.height
            
            if y > sceneScrollView.bounds.height {
                contentSizeA = y - sceneScrollView.bounds.height
            }
        }

        y = offset
        x = startPointB

        for tank in tanksB {
            sceneScrollView.addSubview(tank)
            tank.frame.origin.x = x
            tank.frame.origin.y = y
            tank.transform = CGAffineTransform(rotationAngle: (.pi))

            y += offset + tank.frame.size.height

            if y > sceneScrollView.bounds.height {
                contentSizeB = y - sceneScrollView.bounds.height
            }

        }
        
        sceneHeightConstraint.constant = max(contentSizeA, contentSizeB)
        
    }

}

