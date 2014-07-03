//
//  TileView.swift
//  SampleWhiteTileGame
//
//  Created by Thahir Maheen on 6/26/14.
//  Copyright (c) 2014 Thahir Maheen. All rights reserved.
//

import UIKit

enum TileColor {
    case WhiteColor
    case BlackColor
    case RedColor
    case GrayColor
    
    // returns the appropriate color for each enum value
    func color() -> UIColor {
        switch self {
        case .WhiteColor:   return UIColor.whiteColor()
        case .BlackColor:   return UIColor.blackColor()
        case .RedColor:     return UIColor.redColor()
        case .GrayColor:     return UIColor.grayColor()
        }
    }
    
    // returns the enum value for passed color
    func tileColor(myColor : UIColor) -> TileColor {
        if myColor.isEqual(UIColor.whiteColor()) { return .WhiteColor }
        else if myColor.isEqual(UIColor.blackColor()) { return .BlackColor }
        else { return .RedColor }
    }
}

@objc protocol TileViewDelegate {
    func viewTapped(success : Bool)
}

class TileView: UIButton {
    
    var tileViewDelegate : TileViewDelegate?
    
    var tileColor : TileColor {
    didSet {
        self.backgroundColor = tileColor.color()
    }
    }
    
    init(frame: CGRect) {
        tileColor = .WhiteColor
        super.init(frame: frame)
        
        configureView()
    }
    
    convenience init(myTileColor : TileColor) {
        
        self.init(frame: CGRectMake(0, 0, 80, 120))
        tileColor = myTileColor
        
    }
    
    convenience init() {
        self.init(myTileColor : .WhiteColor)
    }
    
    func configureView () {
        
        // set a border for the view
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.grayColor().CGColor
        
        // add target to map taps
        addTarget(self, action: Selector("viewTapped:"), forControlEvents: .TouchUpInside)
        
    }
    
    func viewTapped(sender : TileView) {
        sender.tileColor == .BlackColor ? correctTap() : wrongTap()
    }
    
    func correctTap() {
        self.tileColor = .GrayColor
        tileViewDelegate?.viewTapped(true)
    }
    
    func wrongTap() {
        tileColor = .RedColor
        shake()
        tileViewDelegate?.viewTapped(false)
    }
    
    var shakeDirection : CGFloat = -1
    var shakeCount : Int = 0
    func shake() {
        
        self.superview.bringSubviewToFront(self)
        
        UIView.animateWithDuration(0.03, delay: 0, options: .CurveEaseInOut, animations: {
            self.transform = CGAffineTransformMakeTranslation(5 * self.shakeDirection, 0)
            }, completion: {(finished : Bool) in
                self.transform = CGAffineTransformIdentity
                if self.shakeCount > 10 {
                    self.shakeCount = 0
                    return
                }
                self.shakeCount++
                self.shakeDirection *= -1
                self.shake()
            })
    }
}

