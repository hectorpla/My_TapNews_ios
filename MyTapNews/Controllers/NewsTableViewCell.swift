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
    
    var imageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        print("fetching image: \(self.imageUrl!)")
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: self.imageUrl!)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.NewsImage.image = image
                    }
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
