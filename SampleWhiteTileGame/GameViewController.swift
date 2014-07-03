//
//  GameViewController.swift
//  SampleWhiteTileGame
//
//  Created by Thahir Maheen on 6/26/14.
//  Copyright (c) 2014 Thahir Maheen. All rights reserved.
//

import UIKit

let kCellReuseIdentifier = "kTileViewCell"
let numberOfRows = 100000

class GameViewController: UITableViewController, TileViewCellDelegate, GameTimerDelegate {

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

        // setup the game timer
        setupGameTimer()
        
        // start the timer
        gameTimer!.startTimer()
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
        if completion >= 1 { performSegueWithIdentifier("kScoreView", sender: self) }
    }
}
