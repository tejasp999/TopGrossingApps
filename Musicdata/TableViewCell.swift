//
//  TableViewCell.swift
//  Musicdata
//
//  Created by Teja PV on 3/6/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import SwiftyJSON
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistId: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    public var jsonDict : JSON = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
