//
//  AvatarModel.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 22.11.2020.
//

import UIKit

//@IBDesignable
class AvatarModel: UIView {
    
    var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFill
        avatar.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        avatar.layer.borderWidth = 0.3
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAvatar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAvatar()
    }
    
    
    private func setupAvatar() {
        backgroundColor = .clear
        addSubview(avatar)
        
        avatar.clipsToBounds = true
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        
        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatar.trailingAnchor.constraint(equalTo: trailingAnchor),
            avatar.topAnchor.constraint(equalTo: topAnchor),
            avatar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
    }
    
    
    // MARK: - Проверить работу @IBInspectable
    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var shadowOpacity: Float = 0.9 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func avatarCompression(_ view: UIView) {
        let compress = CASpringAnimation(keyPath: "transform.scale")
        compress.fromValue = 1
        compress.toValue = 0.9
        compress.duration = 2
        compress.damping = 1
        compress.mass = 0.5
        compress.stiffness = 100
//        compress.beginTime = CACurrentMediaTime()
//        compress.fillMode = CAMediaTimingFillMode.backwards
//        compress.isRemovedOnCompletion = true
        view.layer.add(compress, forKey: nil)
    }
}
