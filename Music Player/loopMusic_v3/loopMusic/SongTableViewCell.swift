//
//  SongTableViewCell.swift
//  loopMusic
//
//  Created by ritu sharma on 31/01/2018.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell
{

    static let reuseIdentifier = "SongCell"
    
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var lblSongName: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
}
