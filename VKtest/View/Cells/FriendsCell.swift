//
//  FriendsCell.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 24.11.2020.
//

import UIKit

class FriendsCell: UITableViewCell {

//    @IBOutlet weak var avatarView: AvatarModel!
    
    
    @IBOutlet weak var avatar: UIImageView!
//        = {
//        let avatar = UIImageView()
//        avatar.contentMode = .scaleAspectFill
//        avatar.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
//        avatar.layer.borderWidth = 0.3
//        avatar.translatesAutoresizingMaskIntoConstraints = false
//        return avatar
//    }()
    
    @IBOutlet weak var nameLabel: UILabel!
    
//    @IBAction func compress(_ sender: Any) {
//        avatarView.avatarCompression(avatarView)
//    }
    
}
