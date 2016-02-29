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
    
    var resetButton : UIButton = UIButton(frame: CGRectZero)
    
    var canvasView : CanvasView!
    
    var replayView: ReplayCanvasView = ReplayCanvasView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canvasView = CanvasView()
        self.canvasView.frame = self.view.frame
        self.canvasView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.canvasView)
        
        self.clearButton.setTitle("Clear", forState: UIControlState.Normal)
        self.clearButton.sizeToFit()
        self.clearButton.center.x = self.clearButton.frame.height
        self.clearButton.center.y = self.clearButton.frame.height
        self.clearButton.addTarget(self, action: "clearButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.clearButton)
        
        self.replayButton.setTitle("Replay", forState: UIControlState.Normal)
        self.replayButton.sizeToFit()
        self.replayButton.center.x = UIScreen.mainScreen().bounds.width - self.replayButton.frame.height
        self.replayButton.center.y = self.replayButton.frame.height
        self.replayButton.addTarget(self, action: "replayButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.replayButton)
        
        
    }
    
    
    func clearButtonPressed(){
        self.canvasView.finishedPaths.removeAll()
        self.canvasView.ongoingPath = nil
        self.canvasView.startTime = NSDate.timeIntervalSinceReferenceDate()
        self.canvasView.setNeedsDisplay()
    }
    
    
    
    func replayButtonPressed(){
        
        self.canvasView.hidden = true
        
        self.replayView = ReplayCanvasView(frame: self.canvasView.frame)
        self.replayView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.replayView)
        
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.sizeToFit()
        self.resetButton.center.x = self.resetButton.frame.height
        self.resetButton.center.y = self.resetButton.frame.height
        self.resetButton.addTarget(self, action: "resetButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.resetButton)
        
        
        dispatch_after(1, dispatch_get_main_queue()) { () -> Void in
            self.replayView.replay(self.canvasView.finishedPaths)
        }
    }
    
    
    func resetButtonPressed(){
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        self.viewDidLoad()
    }
    
    
    

}


























