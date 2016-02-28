//
//  ReplayCanvasView.swift
//  CanvasWithReplay
//
//  Created by ParkSangHa on 2015. 11. 25..
//  Copyright © 2015년 ParkSangHa. All rights reserved.
//

import UIKit

class ReplayCanvasView: UIView {
    
    enum Status {
        case BeforeReplay
        case WillReplay
        case DidReplay
        case Replaying
        case DidFinishReplaying
        case AfterReplay
    }
    
    var pathIndex: Int = 0
    var pointIndex: Int = 0
    
    var finishedPaths = [CustomBezierPath]()
    var ongoingPath : CustomBezierPath?
    
    var originalPaths: [CustomBezierPath]?
    
    var replayMode: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func replay(originalPaths: [CustomBezierPath]){
        self.replayMode = true
        self.originalPaths = originalPaths
        for originalPath in originalPaths{
            for index in 0...originalPath.pointArray.count-1{
                let timelapse = originalPath.timelapseArray[index]

                NSTimer.scheduledTimerWithTimeInterval(timelapse, target: self, selector: "redraw", userInfo: nil, repeats: false)
            }
        }
    }
    
    func redraw() {
        if self.originalPaths != nil {
            
            if self.pointIndex == 0 {
                self.ongoingPath = CustomBezierPath()
            }
            self.ongoingPath!.addElement(point: self.originalPaths![self.pathIndex].pointArray[self.pointIndex],
                                        timelapse: self.originalPaths![self.pathIndex].timelapseArray[self.pointIndex])
            
            
            self.pointIndex++
            
            if self.pointIndex >= self.originalPaths![self.pathIndex].pointArray.count {
                
                self.finishedPaths.append(self.originalPaths![self.pathIndex])
                
                print("finishedPathCount : \(self.finishedPaths.count)")
                
                self.pathIndex++
                self.pointIndex = 0
                
            }
            
            self.setNeedsDisplay()
        }

        
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        for path in finishedPaths{
            path.stroke()
        }
        if let _ = self.ongoingPath {
            self.ongoingPath!.stroke()
        }
    }
    
    
    
    

}
