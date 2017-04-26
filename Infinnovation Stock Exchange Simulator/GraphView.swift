//
//  GraphView.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 25/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable
class GraphView: UIView {
    
    @IBInspectable var graphAxisColor: UIColor = .black
    @IBInspectable var graphPointColor: UIColor = .blue
    @IBInspectable var graphLineColor: UIColor = .blue
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        // draw the axis for the graph
        let xAxisLine = UIBezierPath()
        xAxisLine.move(to: CGPoint(x: 0.0, y: rect.height - 20.0))
        xAxisLine.addLine(to: CGPoint(x: rect.width, y: rect.height - 20.0))
        xAxisLine.close()
        
        let yAxisLine = UIBezierPath()
        yAxisLine.move(to: CGPoint(x: 20.0, y: 0.0))
        yAxisLine.addLine(to: CGPoint(x: 20.0, y: rect.height))
        yAxisLine.close()
        
        graphAxisColor.setStroke()
        graphAxisColor.setFill()
        
        xAxisLine.stroke()
        
        yAxisLine.stroke()
        
        // make demo graph
        makeGraphing(rect)
    }
    
    func makeGraphing(_ rect: CGRect) {
        let pointRadius: CGFloat = 5.0
        let originOffset: CGFloat = pointRadius / 2;
        
        graphPointColor.setFill()
        graphLineColor.setStroke()
        
        let originPoint = CGRect(x: 20.0 - originOffset, y: rect.height - 20.0 - originOffset, width: 5.0, height: 5.0)
        let originPath = UIBezierPath(ovalIn: originPoint)
        originPath.fill()
        
        var xI: CGFloat = 20.0
        var yI: CGFloat = rect.height - 20.0
        
        let xOff: CGFloat = (rect.width - 20.0) / 20
        let yOff: CGFloat = (rect.height - 20.0 - 0) / 20
        
        var i = 0
        while(i < 20) {
            xI = xI + xOff
            yI = yI - yOff
            
            let line = UIBezierPath()
            line.move(to: CGPoint(x: xI - xOff, y: yI + yOff))
            line.addLine(to: CGPoint(x: xI, y: yI))
            line.close()
            line.stroke()
            
            let point = CGRect(x: xI - originOffset, y: yI - originOffset, width: pointRadius, height: pointRadius)
            let path = UIBezierPath(ovalIn: point)
            path.fill()
            
            i = i + 1
        }
        
    }

}
