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
        
        prepareGameView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        doSingleAnimation()
        gameTimer = GameTimer(totalTime: 10, timerDelegate: self)
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
    
    func doSingleAnimation() {
        tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: index--, inSection: 0), atScrollPosition: .Bottom, animated: true)
    }
    
    func tileTapped(success: Bool) {
        if success {
            updateScore()
            doSingleAnimation()
        }
        else {
            performSegueWithIdentifier("kScoreView", sender: self)
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
}
