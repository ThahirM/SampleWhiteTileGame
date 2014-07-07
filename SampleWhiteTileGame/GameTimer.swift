//
//  GameTimer.swift
//  SampleWhiteTileGame
//
//  Created by Thahir Maheen on 6/26/14.
//  Copyright (c) 2014 Thahir Maheen. All rights reserved.
//

import UIKit

protocol GameTimerDelegate {
    func observeTimerCompletion(timer : GameTimer, elapsedTime : Double, completion : Double)
}

class GameTimer: NSObject {
    
    // start time for the timer
    var startTime : NSDate

    // total time (seconds) for the timer
    var time : Double?
    
    // game timer delegate
    var gameTimerDelegate : GameTimerDelegate?
    
    // elapsed time
    var elapsedTime : Double {
    get {
        return NSDate.date().timeIntervalSinceDate(startTime)
    }
    }
    
    // completion percentage
    var complete : Double {
    get {
        
        // return 0 if the timer dont have a fixed time
        if !time { return 0.0 }
        
        let completionPercentage = elapsedTime / time!
        
        return completionPercentage > 1 ? 1 : completionPercentage
    }
    }
    
    init() {
        
        // set the start time
        startTime = NSDate.date()
        
        super.init()
    }
    
    convenience init(totalTime : Double, timerDelegate : GameTimerDelegate) {
        self.init()
        
        // set the total time for the timer
        time = totalTime

        // set the delegate
        gameTimerDelegate = timerDelegate
    }
    
    func obsererForCompletion() {
        
        // notify the delegate about the progress
        gameTimerDelegate?.observeTimerCompletion(self, elapsedTime: elapsedTime, completion: complete)

        // if complete we stop observing
        if complete == 1 {
            return
        }
        else {
            
            // we continue observing
            performClosureAfterDelay(0.5) {
                self.obsererForCompletion()
            }
        }
    }
    
    func startTimer() {
        
        // set the start time
        startTime = NSDate.date()
        
        // observe for completion
        obsererForCompletion()
    }
    
    func stopTimer() {
        time = 0
    }
    
}
