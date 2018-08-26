//
//  LoadingAnimation.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class LoadingAnimation {
    
    var tickCheck = false
    @objc private func addTickLayer(){
        
        if tickCheck == false {
            tickCheck = true
            let path = UIBezierPath()
            
            
            
            let shapeLayerTick = CAShapeLayer()
            shapeLayerTick.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayerTick.strokeColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1).cgColor
            shapeLayerTick.lineWidth = 10
            shapeLayerTick.path = path.cgPath
            
            animationView.layer.addSublayer(shapeLayerTick)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 0.5
            shapeLayerTick.add(animation, forKey: "MyAnimation")
            
        }
        
        
    }
}
