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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(settingsModel?.armamentSettings)
        
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
        }

        for tank in self.tanksB {
            tank.move(view: tank, to: -abs(startPointB - endPointB), animated: true)
        }
    }
    
    @IBAction func shootButton(_ sender: UIBarButtonItem) {
        tanksA[0].die()
    }
    
    func configure(tanks: inout [TankView], with settings: [String: Int]) {
        for (key, value) in settings {
            
            var tankName: String
            
            switch key {
            case "T-34":
                tankName = "T-34"
            case "Tiger-II":
                tankName = "Tiger-II"
            case "M-6":
                tankName = "M-6"
            case "E-100":
                tankName = "E-100"
            case "KV-2":
                tankName = "KV-2"
            case "VK3601":
                tankName = "VK3601"
            case "Panzerkampfwagen IV-G":
                tankName = "Panzerkampfwagen IV-G"
            case "Panzerkampfwagen IV":
                tankName = "Panzerkampfwagen IV"
            default:
                continue
            }
            
            for _ in 0..<value {
                let tank = TankView(image: UIImage(named: tankName))
                tanks.append(tank)
            }
        }
    }

    func configureScene(settings: [String: String]) {
        
        let sceneWidth = max(endPointA, startPointB)
        
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

