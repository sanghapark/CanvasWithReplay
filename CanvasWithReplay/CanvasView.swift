//
//  CanvasView.swift
//  CanvasWithReplay
//
//  Created by ParkSangHa on 2015. 11. 19..
//  Copyright © 2015년 ParkSangHa. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var finishedPaths : NSMutableArray = NSMutableArray()
    var ongoingPath : NSMutableDictionary = NSMutableDictionary()


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let path : CustomBezierPath = CustomBezierPath()
            let point : CGPoint = touch.locationInView(self)

            path.moveToPoint(point)
            path.timelapse = NSDate.timeIntervalSinceReferenceDate()
            
            let address : String = String(unsafeAddressOf(touch))
            print(String(unsafeAddressOf(touch)))
            
            self.ongoingPath[address] = path
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let key = unsafeAddressOf(touch)
            
            print(key)
            
            let path = self.ongoingPath[String(key)]
            
            let point = touch.locationInView(self)

            path!.addLineToPoint(point)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let key = unsafeAddressOf(touch)
            let path : CustomBezierPath = self.ongoingPath[String(key)] as! CustomBezierPath
            
            let point = touch.locationInView(self)

            path.addLineToPoint(point)
            path.timelapse = NSDate.timeIntervalSinceReferenceDate() - path.timelapse!
            
            self.ongoingPath.removeObjectForKey(String(key))
            self.finishedPaths.addObject(path)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.touchesEnded(touches!, withEvent: event)
    }
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        for path in finishedPaths{
            path.stroke()
        }
        for path in ongoingPath.allValues{
            path.stroke()
        }
    }

}
