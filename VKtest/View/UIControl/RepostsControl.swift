//
//  RepostsControl.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 29.11.2020.
//

import UIKit

class RepostsControl: UIControl {
        
    var count: UILabel = {
        let count = UILabel()
        count.text = "5"
        count.textColor = .gray
        count.font = UIFont.systemFont(ofSize: 14)
        count.translatesAutoresizingMaskIntoConstraints = false
        return count
    }()
    
    var repost: UIImageView = {
        let share = UIImageView()
        share.image = UIImage(systemName: "arrowshape.turn.up.right")
        share.contentMode = .scaleAspectFill
        share.tintColor = .gray
        share.translatesAutoresizingMaskIntoConstraints = false
        return share
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfig()
    }
    
    private func setupConfig() {
        
        addSubview(repost)

        NSLayoutConstraint.activate([
            repost.widthAnchor.constraint(equalToConstant: frame.size.height),
            repost.heightAnchor.constraint(equalToConstant: frame.size.height),
            repost.leadingAnchor.constraint(equalTo: leadingAnchor),
            repost.topAnchor.constraint(equalTo: topAnchor),
            repost.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(count)
        
        NSLayoutConstraint.activate([
            count.widthAnchor.constraint(lessThanOrEqualToConstant: 40),
            count.leadingAnchor.constraint(equalTo: repost.trailingAnchor, constant: 5),
            count.topAnchor.constraint(equalTo: topAnchor),
            count.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
