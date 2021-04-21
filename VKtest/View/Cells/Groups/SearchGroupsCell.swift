//
//  SearchGroupsCell.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 24.11.2020.
//

import UIKit

class SearchGroupsCell: UITableViewCell {

//    @IBOutlet weak var avatarView: AvatarModel!
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
//    @IBAction func compress(_ sender: Any) {
//        avatarView.avatarCompression(avatarView)
//    }
    
    override func awakeFromNib() {
        setupConfig()
    }
 
    private func setupConfig() {
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
    }
}
