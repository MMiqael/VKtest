//
//  CloudView.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 02.12.2020.
//

import UIKit

class CloudView: UIView {
 
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(UIColor.red.cgColor)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 250, y: 200))
        path.addLine(to: CGPoint(x: 80, y: 200))
        path.addLine(to: CGPoint(x: 70, y: 170))
        path.addLine(to: CGPoint(x: 75, y: 160))
        
        
        
//        path.move(to: CGPoint(x: 40, y: 20))
//        path.addLine(to: CGPoint(x: 45, y: 40))
//        path.addLine(to: CGPoint(x: 65, y: 40))
//        path.addLine(to: CGPoint(x: 50, y: 50))
//        path.addLine(to: CGPoint(x: 60, y: 70))
//        path.addLine(to: CGPoint(x: 40, y: 55))
//        path.addLine(to: CGPoint(x: 20, y: 70))
//        path.addLine(to: CGPoint(x: 30, y: 50))
//        path.addLine(to: CGPoint(x: 15, y: 40))
//        path.addLine(to: CGPoint(x: 35, y: 40))
        
        path.close()
        path.stroke()
    }
    
    
    
    
    
    
    
    
}
