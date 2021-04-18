//
//  PostFooterModel.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 04.02.2021.
//

import UIKit

//class PostFooterModel: UIView {
//
////    let like = LikeControl()
////    let comment = CommentControl()
////    let share = ShareControl()
////    let views = ViewsControl()
//    
//    var like: LikeControl = {
//        let view = LikeControl()
//        view.backgroundColor = .red
//        return view
//    }()
//    var comment: CommentControl = {
//        let comment = CommentControl()
//        return comment
//    }()
//    var share: ShareControl = {
//        let share = ShareControl()
//        return share
//    }()
//    var views: ViewsControl = {
//        let views = ViewsControl()
//        return views
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupConfig()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupConfig()
//    }
//
//    func setupConfig() {
//
//        addSubview(like)
//
//        NSLayoutConstraint.activate([
//            like.widthAnchor.constraint(equalToConstant: 68),
//            like.leadingAnchor.constraint(equalTo: leadingAnchor),
//            like.topAnchor.constraint(equalTo: topAnchor),
//            like.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//        
//        print("wight: \(like.frame.width),\n height: \(like.frame.height)")
//
//        addSubview(comment)
//
//        NSLayoutConstraint.activate([
//            comment.widthAnchor.constraint(equalToConstant: 68),
//            comment.leadingAnchor.constraint(equalTo: like.trailingAnchor, constant: 5),
//            comment.topAnchor.constraint(equalTo: topAnchor),
//            comment.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//
//        addSubview(share)
//
//        NSLayoutConstraint.activate([
//            share.widthAnchor.constraint(equalToConstant: 68),
//            share.leadingAnchor.constraint(equalTo: comment.trailingAnchor, constant: 5),
//            share.topAnchor.constraint(equalTo: topAnchor),
//            share.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//
//        addSubview(views)
//
//        NSLayoutConstraint.activate([
//            views.widthAnchor.constraint(equalToConstant: 68),
//            views.topAnchor.constraint(equalTo: topAnchor),
//            views.bottomAnchor.constraint(equalTo: bottomAnchor),
//            views.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//    }
//
//}
//
//class LikeView: UIView {
//
//    let like = LikeControl()
//
//
//
//
//
//
//
//}
