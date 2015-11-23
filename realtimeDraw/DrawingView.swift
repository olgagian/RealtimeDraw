//
//  DrawingView.swift
//  realtimeDraw
//
//  Created by ioannis giannakidis on 22/11/15.
//  Copyright © 2015 ioannis giannakidis. All rights reserved.
//

import UIKit


class DrawingView: UIView {
    var currentTouch: UITouch?
    var currentPath: Array<CGPoint>?
    
    
    
    
    
    //MARK: Drawning Functions
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if (currentPath != nil) {
            print(currentPath)
            let context = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context, 0.5)
            CGContextBeginPath(context)
            CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
            if let firstPoint = currentPath?.first{
                CGContextMoveToPoint(context, firstPoint.x, firstPoint.y)
                if (currentPath!.count > 1){
                    for index in 1...currentPath!.count  {
                        let currentPoint  = currentPath![index]
                        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y)
                        
                    }
                }
                CGContextDrawPath(context, CGPathDrawingMode.Stroke)
                print(" -->did draw line in context")
            }
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    //MARK: Touch Functions
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if (currentPath == nil) {
          //  currentTouch = UITouch()
            currentTouch = touches.first
            let currentPoint = currentTouch?.locationInView(self)
            if let currentPoint = currentPoint {
             //   currentPath = Array<CGPoint>()
            currentPath?.append(currentPoint)
                print("Start a new path with point\(currentPoint)")
            }else{
                print("find and empty touch")
            }
            }
            setNeedsDisplay()
            super.touchesBegan(touches, withEvent: event)
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if (currentPath == nil) {
            for touch in  touches {
                if (currentTouch == touch) {
                    let currentPoint = currentTouch?.locationInView(self)
                    if let currentPoint = currentPoint {
                        currentPath?.append(currentPoint)
                        print("Append  a new path with point\(currentPoint)")
                    }else{
                        print("find and empty touch")
                    }

                    
                }
            }
        }
        
        
        
        setNeedsDisplay()

        super.touchesMoved(touches, withEvent: event)
        
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        currentTouch = nil
        currentPath = nil
        print("touch Cancelled")
        setNeedsDisplay()

    super.touchesCancelled(touches, withEvent: event)
    
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if (currentPath == nil) {
            for touch in  touches {
                if (currentTouch == touch) {
                    let currentPoint = currentTouch?.locationInView(self)
                    if let currentPoint = currentPoint {
                        currentPath?.append(currentPoint)
                        print("End  path with point\(currentPoint)")
                    }else{
                        print("find and empty touch")
                    }
                    
                    
                }
            }
        }
        setNeedsDisplay()

        currentTouch = nil
        currentPath = nil
        

        super.touchesEnded(touches , withEvent: event)
    }


}
