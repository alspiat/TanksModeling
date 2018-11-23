//
//  TankView.swift
//  TanksModeling
//
//  Created by Алексей on 11/12/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class TankView: UIImageView {
    
    fileprivate let shootingAnimationKey = "shootingAnimation"
    fileprivate let movingAnimationKey = "movingAnimation"
    
    var healthLabel = UILabel()

    var rate: Int = 0
    var armorPenetration: Int = 0 // Бронепробиваемость пушки
    var armorHealth: Int = 0 {
        didSet {
            checkDie()
            healthLabel.text = "\(String(armorHealth)) HP"
            healthLabel.textColor = UIColor.red
            healthLabel.sizeToFit()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.healthLabel.textColor = .white
            }
        }
    }
    
    func drawHP(rotate: Bool) {
        healthLabel.text = "\(String(armorHealth)) HP"
        healthLabel.textColor = .white
        healthLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        if (rotate) {
            healthLabel.transform = CGAffineTransform(rotationAngle: (.pi))
            healthLabel.frame.origin.y -= healthLabel.bounds.height
            healthLabel.frame.origin.x += 5
        } else {
            healthLabel.frame.origin.y = self.bounds.height
            healthLabel.frame.origin.x += 5
        }
        
        self.addSubview(healthLabel)
    }
    
    func shoot(animated: Bool, tanks: [TankView]) {
        if animated {
            let animation = CAKeyframeAnimation()
            
            let xPos = self.layer.presentation()?.position.x ?? self.layer.position.x
            
            let pathArray = [NSValue(cgPoint: CGPoint(x: xPos, y: self.layer.position.y)),
                             NSValue(cgPoint: CGPoint(x: xPos - 5, y: self.layer.position.y)),
                             NSValue(cgPoint: CGPoint(x: xPos + 5, y: self.layer.position.y)),
                             NSValue(cgPoint: CGPoint(x: xPos, y: self.layer.position.y))]
            
            animation.keyPath = "position"
            animation.values = pathArray
            animation.duration = 0.2
     
          
            
            //Если тунк живой
            if self.armorHealth > 0 {
                //Отрисовываем выстрел
        
                let frontimgview = UIImageView()
                frontimgview.frame = CGRect(x: self.layer.bounds.maxX, y: self.layer.bounds.height / 2 - 12.5, width: 25, height: 25)
                frontimgview.animationRepeatCount = 1
                frontimgview.animationImages = [#imageLiteral(resourceName: "fire")]
                frontimgview.animationDuration = 0.2
        
                self.addSubview(frontimgview)
                
                //Выбираем в кого стрелять
                var maxRate = tanks[0].rate
                var mostDangerousTank = tanks[0]
                
                for tank in tanks {
                    if tank.rate > maxRate {
                        maxRate = tank.rate
                        mostDangerousTank = tank
                    }
                }
            
                if maxRate > 0 {
                    mostDangerousTank.armorHealth -= armorPenetration
                    frontimgview.startAnimating()
                    self.layer.add(animation, forKey: shootingAnimationKey)
                }
            }
        }
    }
    
    
    func move(view: UIView, to offset: CGFloat, animated: Bool) {
        let toPoint: CGPoint = CGPoint(x: view.layer.position.x + offset, y: view.layer.position.y)
        let fromPoint: CGPoint = view.layer.position
        
        if animated {
            let positionAnimation = CABasicAnimation(keyPath: "position")
            positionAnimation.fromValue = NSValue(cgPoint: fromPoint)
            positionAnimation.toValue = NSValue(cgPoint: toPoint)
            positionAnimation.duration = CFTimeInterval(abs(offset / 50.0))
            
            view.layer.add(positionAnimation, forKey: movingAnimationKey)
        }
        
        self.layer.position = toPoint
    }
    
    //Проверяем умер ли  танк, если да, то  обнуляем рейт
    func checkDie() {
        if armorHealth <= 0 {
            healthLabel.isHidden = true
            self.layer.removeAnimation(forKey: movingAnimationKey)
            self.layer.removeAnimation(forKey: shootingAnimationKey)
            self.layer.position = self.layer.presentation()!.position
            self.alpha = 0.5
            rate = 0
        }
    }

   
}
