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
    
    var currents: [Int] = [0, 4, 6, 7, 8, 9, 10, 11, 11, 12, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 20, 21, 21, 22]
    var lvalue: Int = 0
    var hvalue: Int = 22
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        // draw the axis for the graph
        let xAxisLine = UIBezierPath()
        xAxisLine.move(to: CGPoint(x: 5.0, y: rect.height - 5.0))
        xAxisLine.addLine(to: CGPoint(x: rect.width, y: rect.height - 5.0))
        xAxisLine.close()
        
        let yAxisLine = UIBezierPath()
        yAxisLine.move(to: CGPoint(x: 5.0, y: 0.0))
        yAxisLine.addLine(to: CGPoint(x: 5.0, y: rect.height - 5.0))
        yAxisLine.close()
        
        graphAxisColor.setStroke()
        graphAxisColor.setFill()
        
        xAxisLine.stroke()
        
        yAxisLine.stroke()
        
        makeGraph()
    }
    
    func makeGraph() {
        let rect = self.bounds
        
        let pointRadius: CGFloat = 5.0
        let originOffset: CGFloat = pointRadius / 2;
        
        graphPointColor.setFill()
        graphLineColor.setStroke()
        
        let xI: CGFloat = 5.0
        let yI: CGFloat = rect.height - 5.0
        
        let xDiff: CGFloat = (rect.width - xI - 5.0)
        let yDiff: CGFloat = (yI - 0.0 - 5.0)
        
        let currDiff = CGFloat(hvalue - lvalue)
        let diffScale = currDiff / yDiff
        
        let xDiffScale = (xDiff / CGFloat(currents.count - 1))
        
        var i = 0
        while(i < currents.count) {
            let point = CGRect(x: xI + (CGFloat(i) * xDiffScale) - originOffset, y: yI - ((CGFloat(currents[i]) - CGFloat(lvalue)) / diffScale) - originOffset, width: pointRadius, height: pointRadius)
            
            let pointPath = UIBezierPath(ovalIn: point)
            pointPath.fill()
            
            if(i + 1 != currents.count) {
                let line = UIBezierPath()
                line.move(to: CGPoint(x: xI + (CGFloat(i) * xDiffScale), y: yI - ((CGFloat(currents[i]) - CGFloat(lvalue)) / diffScale)))
                line.addLine(to: CGPoint(x: xI + (CGFloat(i + 1) * xDiffScale), y: yI - ((CGFloat(currents[i + 1]) - CGFloat(lvalue)) / diffScale)))
                line.close()
                
                line.stroke()
            }
            
            i = i + 1
        }
        
    }

}
