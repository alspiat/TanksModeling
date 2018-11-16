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
    
    func shoot(animated: Bool) {
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
            
            self.layer.add(animation, forKey: shootingAnimationKey)
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
    
    func die() {
        self.layer.removeAnimation(forKey: movingAnimationKey)
        self.layer.position = self.layer.presentation()!.position
        self.alpha = 0.5
    }

}
