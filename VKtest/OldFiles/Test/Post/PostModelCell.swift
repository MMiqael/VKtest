//
//  PostModelView.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 04.02.2021.
//

import UIKit

class PostModelCell: UITableViewCell {

    @IBOutlet weak var avatarView: AvatarModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var detailsButton: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var controlView: UIView!
    
    @IBAction func avatarButton(_ sender: Any) {
        avatarView.avatarCompression(avatarView)
    }
}
