//
//  NewsTableViewCell.swift
//  MyTapNews
//
//  Created by Hector Lueng on 5/29/18.
//  Copyright © 2018 USC. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var NewsTitleLabel: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    @IBOutlet weak var NewsDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        NewsDescription.isEditable = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
