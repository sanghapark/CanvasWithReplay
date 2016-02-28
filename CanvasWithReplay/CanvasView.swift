//
//  CanvasView.swift
//  CanvasWithReplay
//
//  Created by ParkSangHa on 2015. 11. 19..
//  Copyright © 2015년 ParkSangHa. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    // 끝난 패쓰들 저장하는 배열
    var finishedPaths = [CustomBezierPath]()
    
    // 터치 시작되고 터치끝나기 전까지 저장하는 베이지르 패쓰
    var ongoingPath : CustomBezierPath?
    
    // 마지막 터치가 일어난 시간 (시간차 구하는데 사용됨)
    var startTime = NSDate.timeIntervalSinceReferenceDate()
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            
            // 터치 시작 위치 가져오기
            let point = touch.locationInView(self)
            
            // 터치됬을때 시간 가져오기
            let timelapse = NSDate.timeIntervalSinceReferenceDate()
            
            // 시간차 구하기
            let diff = timelapse - self.startTime
            
            // 베지에르패스 생성
            self.ongoingPath = CustomBezierPath(point: point)
            
            // 온고잉 패쓰에 포인트 타임랩스 추가하기
            self.ongoingPath!.addElement(point: point, timelapse: diff)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            
            // 이동된 터치이벤트 시간
            let timelapse = NSDate.timeIntervalSinceReferenceDate()
            
            // 움직인 터치 위치 가져오기
            let point = touch.locationInView(self)
            
            // 시간차 구하기
            let diff = timelapse - self.startTime
            
            // 온고잉 패쓰에 포인트 타임랩스 추가하기
            self.ongoingPath!.addElement(point: point, timelapse: diff)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            
            // 끝난 터치 위치 가져오기
            let point = touch.locationInView(self)
            
            // 끝난 터치이벤트 시간 및 시간차 구하기
            let timelapse = NSDate.timeIntervalSinceReferenceDate()
            let diff = timelapse - self.startTime
            
            // 온고잉 패쓰에 포인트 타임랩스 추가하기
            self.ongoingPath!.addElement(point: point, timelapse: diff)
            
            // 끝난 패쓰 마무리된 패쓰들 배열에 저장
            self.finishedPaths.append(self.ongoingPath!)
            
        }
        self.setNeedsDisplay()
        
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        for path in finishedPaths{
            path.stroke()
        }
        if let _ = self.ongoingPath {
            self.ongoingPath?.stroke()
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.touchesEnded(touches!, withEvent: event)
    }
    
    
    
    

}
