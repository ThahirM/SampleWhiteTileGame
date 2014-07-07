//
//  GameViewController.swift
//  SampleWhiteTileGame
//
//  Created by Thahir Maheen on 6/26/14.
//  Copyright (c) 2014 Thahir Maheen. All rights reserved.
//

import UIKit

let kCellReuseIdentifier = "kTileViewCell"
let numberOfRows = 1000000

class GameViewController: UITableViewController, TileViewCellDelegate, GameTimerDelegate {
    
    var gameMode : NSString?
    
    var index = numberOfRows - 1
    var score : Int = 0
    var gameTimer : GameTimer?
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // prepare tiles to begin playing
        prepareGameView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // do a single animation to make the tiles in order
        doSingleAnimation()
 
        // prepare game play
        prepareGamePlay()
    }
    
    override func viewDidDisappear(animated: Bool)  {
        super.viewDidDisappear(animated)
        
        gameTimer!.stopTimer()
        gameTimer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return numberOfRows
    }

  
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell = tableView!.dequeueReusableCellWithIdentifier(kCellReuseIdentifier, forIndexPath: indexPath) as TileViewCell
        cell.tileViewCellDelegate = self
        return cell
    }
    
    func prepareGamePlay() {
        
        // initialize offset and speed
        initialOffset = 11999432.0
        initialSpeed = 0.8
        
        // setup the game timer
        setupGameTimer()
        
        if gameMode!.isEqualToString("kModeArcade") {
            autoScroll()
        }
        else if gameMode!.isEqualToString("kModeRace") {
            
            // set the game time
            gameTimer!.time = 10
        }
        else if gameMode!.isEqualToString("kModeTimeAttack") {
            
            // set the game time
            gameTimer!.time = 30
        }
        else { println("XXX unexpected mode") }
        
        // start the timer
        gameTimer!.startTimer()
    }
    
    func prepareGameView() {
        
        // reset tiles
        tableView.reloadData()
        tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: index, inSection: 0), atScrollPosition: .Top, animated: true)
        
        // reset score
        score = 0
    }
    
    func setupGameTimer() {
        
        // get the shared game timer instance
        gameTimer = GameTimer.sharedInstance
        
        // set the delegate to track time changes
        gameTimer!.gameTimerDelegate = self
        
        // set the game time 
        // XXX we need to add different modes later
        gameTimer!.time = 10
    }
    
    func doSingleAnimation() {
        tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: index--, inSection: 0), atScrollPosition: .Bottom, animated: true)
    }
    
    func tileTapped(success: Bool) {
        if success {
            updateScore()
            doSingleAnimation()
        }
        else {
            gameTimer!.stopTimer()
        }
    }

    func updateScore() {
        score++
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {

        if segue!.identifier == "kScoreView" {
            
            gameTimer?.stopTimer()
            
            let scoreView = segue!.destinationViewController as ScoreViewController
            scoreView.score = String(score)
        }
        
    }

    func observeTimerCompletion(timer: GameTimer, elapsedTime: Double, completion: Double) {
        println("timer running \(elapsedTime)")
        if completion >= 1 { performSegueWithIdentifier("kScoreView", sender: self) }
    }
    
    var initialOffset = 11999432.0
    var initialSpeed = 0.8
    var acceleration : CDouble {
    get {
        return initialSpeed > 0.2 ? 0.01 : 0
    }
    }
    
    func autoScroll() {
        
        // repeatedly set offset with animation
        UIView.animateWithDuration(initialSpeed, delay: 0, options: (UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.CurveLinear), animations: {
            let scrollView : UIScrollView = self.tableView as UIScrollView
            self.initialOffset -= 120
            scrollView.setContentOffset(CGPointMake(0, self.initialOffset), animated: false)
            }, completion: {finished in
                self.initialSpeed -= self.initialSpeed * self.acceleration
                self.autoScroll()
            })
    }
}
