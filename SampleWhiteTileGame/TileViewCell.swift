//
//  TileViewCell.swift
//  SampleWhiteTileGame
//
//  Created by Thahir Maheen on 6/26/14.
//  Copyright (c) 2014 Thahir Maheen. All rights reserved.
//

import UIKit

@objc protocol TileViewCellDelegate {
    func tileTapped(success : Bool)
}

class TileViewCell: UITableViewCell, TileViewDelegate {
    
    var tiles : NSMutableArray = []
    var tileViewCellDelegate : TileViewCellDelegate?
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadCells()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        loadCells()
    }
    
    override func layoutSubviews()  {
        super.layoutSubviews()
        
        // reset old cells
        resetCells()
        
        // blacken a random cell
        blackenCell()
    }
    
    func loadCells() -> NSArray {
        
        if Bool(tiles.count) { return tiles }
        
        var cellTiles : NSMutableArray = []
        
        // x offset for arranging tiles
        var offset : CGFloat = 0.0
        
        for _ in 0..4 {
            
            // create a tile
            let tile = TileView()
            
            // set the tile view delegate
            tile.tileViewDelegate = self
            
            // set the required frame
            tile.frame = CGRectMake(offset, 0, tile.frame.width, tile.frame.height)
            
            // add it to the cell
            contentView.addSubview(tile)
            
            // add it to the array for reference
            cellTiles.addObject(tile)
            
            // update offset
            offset += 80.0
        }
        
        // save the tiles for reuse
        tiles = cellTiles
        
        return cellTiles
    }
    
    func resetCells() {
        
        // reset old tiles
        for tile : AnyObject in tiles {
            let myTile : TileView = tile as TileView
            myTile.enabled = true
            myTile.tileColor = .WhiteColor
        }
    }
    
    func blackenCell() {
        
        // generate a random tile to blacken
        let random = arc4random() % 4
        let blackTile : TileView = tiles[Int(random)] as TileView
        
        // blacken the tile
        blackTile.tileColor = .BlackColor
    }
    
    func disableCells() {
        
        // disable cells
        for tile : AnyObject in tiles {
            let myTile : TileView = tile as TileView
            myTile.enabled = false
        }
    }
    
    func viewTapped(success : Bool) {
        disableCells()
        tileViewCellDelegate?.tileTapped(success)
    }
}
