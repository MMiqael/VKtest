//
//  ViewsControl.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 29.11.2020.
//

import UIKit

class ViewsControl: UIControl {
        
    var count: UILabel = {
        let count = UILabel()
        count.text = "2K"
        count.textColor = .lightGray
        // MARK: Установить тонкий стиль текста
        count.font = UIFont.systemFont(ofSize: 13)
        count.translatesAutoresizingMaskIntoConstraints = false
        return count
    }()
    
    var views: UIImageView = {
        let views = UIImageView()
        views.image = UIImage(systemName: "eye")
        views.contentMode = .scaleAspectFill
        views.tintColor = .lightGray
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
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
        
        addSubview(count)
        
        NSLayoutConstraint.activate([
            count.widthAnchor.constraint(lessThanOrEqualToConstant: 40),
            count.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            count.topAnchor.constraint(equalTo: topAnchor),
            count.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(views)

        NSLayoutConstraint.activate([
            views.widthAnchor.constraint(equalToConstant: frame.size.height),
            views.heightAnchor.constraint(equalToConstant: frame.size.height),
            views.trailingAnchor.constraint(equalTo: count.leadingAnchor, constant: -5),
            views.topAnchor.constraint(equalTo: topAnchor),
            views.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
