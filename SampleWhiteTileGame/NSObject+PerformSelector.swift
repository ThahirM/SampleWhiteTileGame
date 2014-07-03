//
//  NSObject+PerformSelector.swift
//  SampleWhiteTileGame
//
//  Created by Thahir Maheen on 7/3/14.
//  Copyright (c) 2014 Thahir Maheen. All rights reserved.
//

import UIKit

protocol PerformSelectorProtocol {
    func performClosureAfterDelay(delay:Double, closure:()->())
}

extension NSObject: PerformSelectorProtocol {
    
    func performClosureAfterDelay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}