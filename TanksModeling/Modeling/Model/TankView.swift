//
//  TankView.swift
//  TanksModeling
//
//  Created by Алексей on 11/12/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class TankView: UIImageView {
    
    let healthLabel = UILabel()
    let shootImageView = UIImageView()

    var rate: Int = 0
    var speed: Double = 0
    var armorPenetration: Int = 0 // Бронепробиваемость пушки
    var position: CGPoint {
        return self.layer.position
    }
    var health: Int = 0 {
        didSet {
            updateHealthLabel(old: oldValue)
        }
    }
    override var transform: CGAffineTransform {
        didSet {
            healthLabel.transform = transform
            healthLabel.frame.origin.y -= (healthLabel.bounds.height + self.bounds.height)
        }
    }
    var height: CGFloat {
        return bounds.height + healthLabel.bounds.height
    }
    var width: CGFloat {
        return bounds.width
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        self.setupShootImageView()
        self.setupHealthLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupShootImageView() {
        shootImageView.frame = CGRect(x: self.layer.bounds.maxX, y: self.layer.bounds.height / 2 - 12.5, width: 25, height: 25)
        shootImageView.animationRepeatCount = 1
        shootImageView.animationImages = [#imageLiteral(resourceName: "fire")]
        shootImageView.animationDuration = 0.2
        
        self.addSubview(shootImageView)
    }
    
    func setupHealthLabel() {
        healthLabel.text = "\(String(health)) HP"
        healthLabel.textColor = .white
        healthLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        healthLabel.frame.origin.x += 10
        healthLabel.frame.origin.y = self.bounds.height
        healthLabel.sizeToFit()
        
        self.addSubview(healthLabel)
    }
    
    func shoot(tank: TankView, animated: Bool) {
        if self.health > 0 {
            if (animated) {
                self.animateShooting()
            }
            tank.health -= armorPenetration
        }
    }
    
    
    func move(to endPoint: CGPoint, animated: Bool) {
        let startPoint = self.layer.position
        
        if animated {
            let distance = sqrt(pow(abs(startPoint.x - endPoint.x), 2) + pow(abs(startPoint.y - endPoint.y), 2))
            let duration = Double(distance) / speed
            
            animateMoving(to: endPoint, duration: duration)
        }
        
        self.layer.position = endPoint
    }
    
    //Проверяем умер ли танк, если да, то обнуляем рейт
    
    func updateHealthLabel(old: Int) {
        checkIsDie()
        healthLabel.text = "\(String(health)) HP"
        healthLabel.sizeToFit()
        
        if old != 0 {
            healthLabel.textColor = UIColor.red
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.healthLabel.textColor = .white
            }
        }
    }
    
    func checkIsDie() {
        if health <= 0 {
            healthLabel.isHidden = true
            self.stopMovingAnimation()
            self.stopShootingAnimation()
            self.layer.position = self.layer.presentation()!.position
            self.alpha = 0.5
            rate = 0
        }
    }

   
}
