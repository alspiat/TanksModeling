//
//  TankView+Animation.swift
//  TanksModeling
//
//  Created by Алексей on 11/25/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

fileprivate let shootingAnimationKey = "shootingAnimation"
fileprivate let movingAnimationKey = "movingAnimation"

extension TankView {
    
    func animateMoving(to endPoint: CGPoint, duration: Double) {
        let startPoint: CGPoint = self.layer.position
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = NSValue(cgPoint: startPoint)
        positionAnimation.toValue = NSValue(cgPoint: endPoint)
        positionAnimation.duration = duration
        
        self.layer.add(positionAnimation, forKey: movingAnimationKey)
    }
    
    func animateShooting() {
        let animation = CAKeyframeAnimation()
        
        let xPos = self.layer.presentation()?.position.x ?? self.layer.position.x
        
        let pathArray = [NSValue(cgPoint: CGPoint(x: xPos, y: self.layer.position.y)),
                         NSValue(cgPoint: CGPoint(x: xPos - 5, y: self.layer.position.y)),
                         NSValue(cgPoint: CGPoint(x: xPos + 5, y: self.layer.position.y)),
                         NSValue(cgPoint: CGPoint(x: xPos, y: self.layer.position.y))]
        
        animation.keyPath = "position"
        animation.values = pathArray
        animation.duration = 0.2
        
        self.layer.add(animation, forKey: shootingAnimationKey)
        shootImageView.startAnimating()
    }
    
    func stopMovingAnimation() {
        self.layer.removeAnimation(forKey: movingAnimationKey)
    }
    
    func stopShootingAnimation() {
        self.layer.removeAnimation(forKey: shootingAnimationKey)
    }
}
