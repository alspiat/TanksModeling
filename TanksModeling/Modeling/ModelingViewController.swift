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
        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5, animations: {
            self.configureTanks()
            self.view.layoutIfNeeded()
        }, completion: { (success) in
            if success {
                self.startModeling()
            }
        })
    }
    
    func mostDangerousTank(from tanks: [TankView]) -> TankView? {
        guard tanks.count > 0 else {
            return nil
        }
        
        //Выбираем в кого стрелять
        var maxRate = tanks[0].rate
        var mostDangerousTank = tanks[0]
        
        for tank in tanks {
            if tank.rate > maxRate {
                maxRate = tank.rate
                mostDangerousTank = tank
            }
        }
        
        return mostDangerousTank
    }
    
    func startModeling() {
        for tank in self.tanksA {
            tank.move(to:  CGPoint(x: endPointA, y: tank.position.y), animated: true)
            
            for i in 0..<shootCount {
                let timeout = DispatchTimeInterval.milliseconds(Int(arc4random_uniform(1000) + 500) * (i + 1))
                DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                    if let mostDangerousTank = self.mostDangerousTank(from: self.tanksB) {
                        tank.shoot(tank: mostDangerousTank, animated: true)
                    }
                }
            }
        }
        
        for tank in self.tanksB {
            tank.move(to: CGPoint(x: endPointB, y: tank.position.y), animated: true)
            
            for i in 0..<shootCount {
                let timeout = DispatchTimeInterval.milliseconds(Int(arc4random_uniform(1000) + 500) * (i + 1))
                DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                    if let mostDangerousTank = self.mostDangerousTank(from: self.tanksA) {
                        tank.shoot(tank: mostDangerousTank, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func shootButton(_ sender: UIBarButtonItem) {
        startModeling()
    }
    
    func configure(tanks: inout [TankView], with settings: [String: Int]) {
        for (key, value) in settings {
            for _ in 0..<value {
                switch key {
                case "T-34":
                    tanks.append(TankView.T34)
                case "Tiger-II":
                    tanks.append(TankView.Tiger)
                case "M-6":
                    tanks.append(TankView.M6)
                case "E-100":
                    tanks.append(TankView.E100)
                case "KV-2":
                    tanks.append(TankView.KV2)
                case "VK3601":
                    tanks.append(TankView.VK3601)
                case "Panzerkampfwagen IV-G":
                    tanks.append(TankView.PanzerkampfwagenIVG)
                case "Panzerkampfwagen IV":
                    tanks.append(TankView.PanzerkampfwagenIV)
                default:
                    continue
                }
            }
        }
    }

    func configureScene(settings: [String: String]) {
        
        if let landscape = settings["Ландшафт"] {
            sceneBackgroundView.image = UIImage(named: landscape)
        }

        if let darkness = settings["Время суток"],
            let darknessValue = Double(darkness) {
            sceneLightView.alpha = CGFloat(darknessValue)
        }
        
    }
    
    func configureTanks() {
        
        let offset: CGFloat = 20
        
        let sceneWidth = max(endPointA, startPointB, startPointA, endPointB)
        
        if sceneWidth > sceneScrollView.bounds.width {
            sceneWidthConstraint.constant = sceneWidth - sceneScrollView.bounds.width
        }
        
        var y: CGFloat = offset
        var x: CGFloat = startPointA
        
        var contentSizeA: CGFloat = 0
        var contentSizeB: CGFloat = 0
        
        for tank in tanksA {
            sceneScrollView.addSubview(tank)
            tank.frame.origin.x = x
            tank.frame.origin.y = y
            
            y += tank.height + offset
            
            if y > sceneScrollView.bounds.height {
                contentSizeA = y - sceneScrollView.bounds.height
            }
        }
        
        y = offset
        x = startPointB
        
        for tank in tanksB {
            sceneScrollView.addSubview(tank)
            tank.frame.origin.x = x - tank.width
            tank.frame.origin.y = y
            tank.transform = CGAffineTransform(rotationAngle: (.pi))
            
            y += tank.height + offset
            
            if y > sceneScrollView.bounds.height {
                contentSizeB = y - sceneScrollView.bounds.height
            }
            
        }
        
        sceneHeightConstraint.constant = max(contentSizeA, contentSizeB)
        
    }

}

