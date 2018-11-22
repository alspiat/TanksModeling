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
    

    var tankHP: Int = 0 {
        didSet {
            checkDie()
        }
    }
    var tankRate: Int = 0
    
    
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
            
            
            //Отрисовываем выстрел
    
            let frontimgview = UIImageView()
            frontimgview.frame = CGRect(x: self.layer.bounds.maxX, y: 0, width: 30, height: 30)
            frontimgview.transform = frontimgview.transform.rotated(by: CGFloat(Double.pi / 2)) // сделать поворот пикчи огня
            frontimgview.animationRepeatCount = 1
            frontimgview.animationImages = [#imageLiteral(resourceName: "fire")]
            frontimgview.animationDuration = 0.2
            self.addSubview(frontimgview)
            self.layer.add(animation, forKey: shootingAnimationKey)
            
            //Выбираем в кого стрелять
            var maxRate = tanks[0].tankRate
            var mostDangerousTank = tanks[0]
            
            for tank in tanks {
                if tank.tankRate > maxRate {
                    maxRate = tank.tankRate
                    mostDangerousTank = tank
                }
            }
        
            mostDangerousTank.tankHP -= 1
            frontimgview.startAnimating()
    
            
            
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
        if tankHP <= 0 {
            self.layer.removeAnimation(forKey: movingAnimationKey)
            self.layer.position = self.layer.presentation()!.position
            self.alpha = 0.5
            tankRate = 0
        }
    }

}
