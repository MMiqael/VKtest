//
//  GroupCell.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 07.02.2021.
//

import UIKit

class GroupCell: UITableViewCell {


    @IBOutlet weak var avatarView: AvatarModel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBAction func avatarButton(_ sender: Any) {
        avatarView.avatarCompression(avatarView)
    }
}
