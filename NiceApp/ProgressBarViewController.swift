//
//  ProgressBarViewController.swift
//  NiceApp
//
//  Created by 이서영 on 2023/05/04.
//

import UIKit

class ProgressBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 원 그리기
        let shapeLayer = CAShapeLayer()
        
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
//
//        let basicAnimation = CABasicAnimation(keyPath:"strokeEnd" )
//
//        basicAnimation.toValue = 1
//
//        shapeLayer.add(basicAnimation, forKey:"urSoBBasic")
//
//
//
    }
}
