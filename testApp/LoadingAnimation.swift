//
//  LoadingAnimation.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class LoadingAnimation {
    // пока делал понял что будет скучным , вместо сплеш скрина вставить что бы загрузку прикрыть.
    let animationView = UIView(frame: (CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))
    let shapeLayer = CAShapeLayer()
    var tickCheck = false
    func addTickLayer() -> UIView{
        
        if tickCheck == false {
            tickCheck = true
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 36, y: 360)) //1
            path.addLine(to: CGPoint(x: 110, y: 330))//2
            path.addLine(to: CGPoint(x: 150, y: 290))//3
            path.addLine(to: CGPoint(x: 220, y: 290))//4
            path.addLine(to: CGPoint(x: 245, y: 330))//5
            path.addLine(to: CGPoint(x: 305, y: 330))//6
            path.addLine(to: CGPoint(x: 305, y: 380))//7
            path.addLine(to: CGPoint(x: 230, y: 380))//8
            path.addCurve(to: CGPoint(x: 210, y: 380), controlPoint1: CGPoint(x:225 , y: 400), controlPoint2: CGPoint(x: 215, y: 400))//9-----
            path.addLine(to: CGPoint(x: 150, y: 380))//11
            path.addCurve(to: CGPoint(x: 120, y: 380), controlPoint1: CGPoint(x:135 , y: 400), controlPoint2: CGPoint(x: 125, y: 400))//12-----
            path.addLine(to: CGPoint(x: 36, y: 380))//14
            path.addLine(to: CGPoint(x: 36, y: 360))//15

            let shapeLayerTick = CAShapeLayer()
            shapeLayerTick.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayerTick.strokeColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
            shapeLayerTick.lineWidth = 10
            shapeLayerTick.lineCap = kCALineCapRound
            shapeLayerTick.path = path.cgPath
            
            animationView.layer.addSublayer(shapeLayerTick)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 0.5
            shapeLayerTick.add(animation, forKey: "MyAnimation")
        }
        return animationView
    }
}
