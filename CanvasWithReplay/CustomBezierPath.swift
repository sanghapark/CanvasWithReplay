//
//  CustomBezierPath.swift
//  CanvasWithReplay
//
//  Created by ParkSangHa on 2015. 11. 19..
//  Copyright © 2015년 ParkSangHa. All rights reserved.
//

import UIKit

class CustomBezierPath : UIBezierPath{
//    var timelapse : NSTimeInterval?
    
    var timelapseArray : [NSTimeInterval] = [NSTimeInterval]()
    var pointArray : [CGPoint] = [CGPoint]()
    
    override init() {
        super.init()
    }
    
    init(point: CGPoint) {
        super.init()
        self.moveToPoint(point)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addElement(point point: CGPoint, timelapse: NSTimeInterval) {
        if pointArray.count > 0 {
            self.addLineToPoint(point)
        } else {
            self.moveToPoint(point)
        }
        
        pointArray.append(point)
        timelapseArray.append(timelapse)
    }

}