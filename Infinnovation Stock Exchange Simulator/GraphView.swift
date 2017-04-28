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
    
    // IB defines the colors to be used for various elements in the line graph
    @IBInspectable var graphAxisColor: UIColor = .black
    @IBInspectable var graphPointColor: UIColor = .blue
    @IBInspectable var graphLineColor: UIColor = .blue
    
    // sample values whose graph is to be plotted
    var currents: [Int] = [49, 57, 71, 18, 92, 81, 72, 54, 8, 2, 78, 93, 47, 56, 41, 10, 29, 72, 78, 51, 47, 21, 33, 81, 28, 8, 1, 58, 19, 53, 0]
    // lowest and highest values in the actual graph used for calibrating the scale in the graph
    var lvalue: Int = 0
    var hvalue: Int = 95
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        // defines an offset to place the axes of the graph with respect to rect
        let axisOffset: CGFloat = 20.0
        // defines the point of origin of graph in terms of rect position
        let origin: CGPoint = CGPoint(x: axisOffset, y: rect.height - axisOffset)
        
        // draws the x and y axis of the graph with the specified offset
        drawAxes(axisOffset: axisOffset)
        
        // plots a graph based on the integral values provide and highest and lowest values
        plotGraph(originPoint: origin, borderOffset: 10.0, pointRadius: 5.0, yValues: currents, yLowest: lvalue, yHighest: hvalue)
    }
    
    func drawAxes(axisOffset: CGFloat) {
        // refers to current rect
        let rect = self.bounds
        
        // draw the axes for the graph
        
        // draws the x axis line for the graph
        let xAxisLine = UIBezierPath()
        xAxisLine.move(to: CGPoint(x: axisOffset, y: rect.height - axisOffset))
        xAxisLine.addLine(to: CGPoint(x: rect.width, y: rect.height - axisOffset))
        xAxisLine.close()
        
        // draws the y axis line for the graph
        let yAxisLine = UIBezierPath()
        yAxisLine.move(to: CGPoint(x: axisOffset, y: 0.0))
        yAxisLine.addLine(to: CGPoint(x: axisOffset, y: rect.height - axisOffset))
        yAxisLine.close()
        
        // uses the color specified in IB to stroke the axes lines
        graphAxisColor.setStroke()

        xAxisLine.stroke()
        yAxisLine.stroke()
    }
    
    func plotGraph(originPoint: CGPoint, borderOffset: CGFloat, pointRadius: CGFloat, yValues values: [Int], yLowest lvalue: Int, yHighest hvalue: Int) {
        // refers to the current rect
        let rect = self.bounds
        
        // defines a constant float value to help in drawing points on screen with rects
        let originOffsetForPoint: CGFloat = pointRadius / 2;
        
        // sets the colors for the line graph that is to be plotted based on colours specified in IB
        graphPointColor.setFill()
        graphLineColor.setStroke()
        
        // defines the x, y positions on rect of the origin of the graph
        let xOrigin: CGFloat = originPoint.x
        let yOrigin: CGFloat = originPoint.y
        
        // defines the difference in x, y from highest postion of graph to lowest position on graph along x, y respectively as per points on the rect
        let xDiff: CGFloat = (rect.width - xOrigin - borderOffset)
        let yDiff: CGFloat = (yOrigin - 0.0 - borderOffset)
        
        // defines the difference in highest and lowest of the actual graph values
        let valDiff = CGFloat(hvalue - lvalue)
        // defines a scaling calibration value useful for plotting of y points on graph, differenceInActualValuesOfGraph/differenceInYLimitOfRect
        let yDiffScale = valDiff / yDiff
        
        // defines a scaling calibration value useful for plotting of x points on graph, provided that x incremennts by one for each consecutive value of y
        let xDiffScale = (xDiff / CGFloat(values.count - 1))
        
        // counter to run a loop to plot points and lines on the graph for each of the values
        var i = 0
        while(i < values.count) {
            // actual rect point for the graph point that is to be plotted on the graph
            let point = CGPoint(x: xOrigin + (CGFloat(i) * xDiffScale), y: yOrigin - ((CGFloat(values[i]) - CGFloat(lvalue)) / yDiffScale))
            // defining a rect with an origin offset at that point
            let pointRect = CGRect(x: point.x - originOffsetForPoint, y: point.y - originOffsetForPoint, width: pointRadius, height: pointRadius)
            // drawing a oval/circle in that rect to represent a point on the actual graph
            let pointPath = UIBezierPath(ovalIn: pointRect)
            // fill the oval with color
            pointPath.fill()
            
            // draw a line between this point and the next point on the graph that is to plotted on next iteration of the loop
            if(i + 1 != values.count) {
                // bezier path to draw the line
                let line = UIBezierPath()
                
                // point to
                let nextPoint = CGPoint(x: xOrigin + (CGFloat(i + 1) * xDiffScale), y: yOrigin - ((CGFloat(values[i + 1]) - CGFloat(lvalue)) / yDiffScale))
                
                // line to start from current defined point
                line.move(to: point)
                // line to be drawn upto the next defined point
                line.addLine(to: nextPoint)
                line.close()
                
                // stroke the line with color
                line.stroke()
            }
            
            // increment loop counter
            i = i + 1
        }
        
    }

}
