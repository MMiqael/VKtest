//
//  NewsfeedCell.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 28.11.2020.
//

import UIKit

class NewsfeedCell: UITableViewCell {
            
    //    @IBOutlet weak var avatarView: AvatarModel!

    @IBOutlet weak var newsFeedTopView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var viewControl: UIView!
    @IBOutlet weak var likeControl: LikesControl!
    @IBOutlet weak var commentsControl: CommentsControl!
    @IBOutlet weak var repostsControl: RepostsControl!
    @IBOutlet weak var viewsControl: ViewsControl!
    
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var detailButton: UIButton! // Без предназначения
    
    override func awakeFromNib() {
        setupConfig()
    }
 
    private func setupConfig() {
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
        avatar.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        avatar.layer.borderWidth = 0.3
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
    }
}
