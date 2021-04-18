//
//  LikesControl.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 23.11.2020.
//

import UIKit

class LikesControl: UIControl {
    
    var isLiked = true
    
    var likesCount = 0
    
    var count: UILabel = {
        let count = UILabel()
        count.textColor = .gray
        count.font = UIFont.systemFont(ofSize: 13)
        count.translatesAutoresizingMaskIntoConstraints = false
        return count
    }()
    
    var like: UIImageView = {
        let like = UIImageView()
        like.image = UIImage(systemName: "heart")
        like.contentMode = .scaleAspectFill
        like.tintColor = .gray
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    let likesNetworkService = LikesNetworkService()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfig()
    }
    
    private func setupConfig() {
        
        addSubview(like)

        NSLayoutConstraint.activate([
            like.widthAnchor.constraint(equalToConstant: frame.size.height),
            like.heightAnchor.constraint(equalToConstant: frame.size.height),
            like.leadingAnchor.constraint(equalTo: leadingAnchor),
            like.topAnchor.constraint(equalTo: topAnchor),
            like.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        count.text = String(likesCount)
        
        addSubview(count)
        
        NSLayoutConstraint.activate([
            count.widthAnchor.constraint(lessThanOrEqualToConstant: 40),
            count.leadingAnchor.constraint(equalTo: like.trailingAnchor, constant: 5),
            count.topAnchor.constraint(equalTo: topAnchor),
            count.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        if isLiked {
            
            likesCount += 1
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.25, options: [.autoreverse]) {
                self.like.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            } completion: { (_) in
                self.like.transform = .identity
            }
            
            UIView.transition(with: count, duration: 0.2, options: .transitionCrossDissolve) {
                self.count.text = String(self.likesCount)
                self.count.textColor = .red
            }
            
            UIView.transition(with: like, duration: 0.1, options: .transitionCrossDissolve) {
                self.like.image = UIImage(systemName: "heart.fill")
                self.like.tintColor = .red
            }
            
            isLiked = false
            
        } else {
            
            likesCount -= 1
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.25, options: [.autoreverse]) {
                self.like.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { (_) in
                self.like.transform = .identity
            }
            
            UIView.transition(with: count, duration: 0.2, options: .transitionCrossDissolve) {
                self.count.text = String(self.likesCount)
                self.count.textColor = .gray
            }
            
            UIView.transition(with: like, duration: 0.1, options: .transitionCrossDissolve) {
                self.like.image = UIImage(systemName: "heart")
                self.like.tintColor = .gray
            }

            isLiked = true
        }
    }
}
