//
//  HomeViewController.swift
//  SampleWhiteTileGame
//
//  Created by Thahir Maheen on 7/3/14.
//  Copyright (c) 2014 Thahir Maheen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    init(coder aDecoder: NSCoder!)  {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonActionArcade(sender: UIButton) {
        performSegueWithIdentifier("kModeArcade", sender: self)
    }
    
    @IBAction func buttonActionRace(sender: UIButton) {
        performSegueWithIdentifier("kModeRace", sender: self)
    }
    
    @IBAction func buttonActionTimeAttack(sender: UIButton) {
        performSegueWithIdentifier("kModeTimeAttack", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        // set the correct game mode
        let vc = segue!.destinationViewController as GameViewController
        vc.gameMode = segue!.identifier
    }
}
