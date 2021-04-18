//
//  CommentsControl.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 29.11.2020.
//

import UIKit

class CommentsControl: UIControl {
        
    var count: UILabel = {
        let count = UILabel()
        count.text = "14"
        count.textColor = .gray
        count.font = UIFont.systemFont(ofSize: 13)
        count.translatesAutoresizingMaskIntoConstraints = false
        return count
    }()
    
    var comment: UIImageView = {
        let comment = UIImageView()
        comment.image = UIImage(systemName: "bubble.left")
        comment.contentMode = .scaleAspectFill
        comment.tintColor = .gray
        comment.translatesAutoresizingMaskIntoConstraints = false
        return comment
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
        
        addSubview(comment)

        NSLayoutConstraint.activate([
            comment.widthAnchor.constraint(equalToConstant: frame.size.height),
            comment.heightAnchor.constraint(equalToConstant: frame.size.height),
            comment.leadingAnchor.constraint(equalTo: leadingAnchor),
            comment.topAnchor.constraint(equalTo: topAnchor),
            comment.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(count)
        
        NSLayoutConstraint.activate([
            count.widthAnchor.constraint(lessThanOrEqualToConstant: 40),
            count.leadingAnchor.constraint(equalTo: comment.trailingAnchor, constant: 5),
            count.topAnchor.constraint(equalTo: topAnchor),
            count.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
