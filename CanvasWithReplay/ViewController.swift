//
//  ViewController.swift
//  CanvasWithReplay
//
//  Created by ParkSangHa on 2015. 11. 19..
//  Copyright © 2015년 ParkSangHa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var clearButton : UIButton = UIButton(frame: CGRectZero)
    var replayButton : UIButton = UIButton(frame: CGRectZero)
    
    var canvasView : CanvasView = CanvasView(frame: CGRectZero)
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.canvasView.frame = self.view.frame
        self.canvasView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.canvasView)
        
        
        self.clearButton.setTitle("Clear", forState: UIControlState.Normal)
        self.clearButton.sizeToFit()
        self.clearButton.center.x = self.clearButton.frame.height
        self.clearButton.center.y = self.clearButton.frame.height
        self.clearButton.addTarget(self, action: "clearButtonPressed", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(self.clearButton)
        
        self.replayButton.setTitle("Replay", forState: UIControlState.Normal)
        self.replayButton.sizeToFit()
        self.replayButton.center.x = UIScreen.mainScreen().bounds.width - self.replayButton.frame.height
        self.replayButton.center.y = self.replayButton.frame.height
        self.replayButton.addTarget(self, action: "replayButtonPressed", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(self.replayButton)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func clearButtonPressed(){

        
        CATransaction.begin()
        self.canvasView.finishedPaths = NSMutableArray()
        self.canvasView.ongoingPath = NSMutableDictionary()
        for layer in self.canvasView.layer.sublayers!{
            layer.removeFromSuperlayer()
        }
        CATransaction.commit()
        self.canvasView.setNeedsDisplay()
    }
    
    func replayButtonPressed(){
        self.canvasView.hidden = true
        let preview = UIView(frame: self.canvasView.frame)
        preview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(preview)
        
        var total : NSTimeInterval = 0.0
        
        for path  in self.canvasView.finishedPaths {
            let tempPath  = path as! CustomBezierPath
            var shapeLayer = CAShapeLayer()
            shapeLayer.path = path.CGPath
            shapeLayer.strokeColor = UIColor.blackColor().CGColor
            shapeLayer.fillColor = nil
            shapeLayer.lineWidth = 1.0
            shapeLayer.lineJoin =  kCALineJoinBevel
            
            var pathAnimation  = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = tempPath.timelapse!
            pathAnimation.fromValue  = String("0.0")
            pathAnimation.toValue = String("1.0")
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(total * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                shapeLayer.addAnimation(pathAnimation, forKey: "strokeEnd")
                preview.layer.addSublayer(shapeLayer)
            })
            
            total += tempPath.timelapse!
            
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(total * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            preview.removeFromSuperview()
            self.canvasView.hidden = false
        }
        
    }
    
    
    

}


























