//
//  LikesIsLiked.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 26.02.2021.
//

import Foundation

struct LikesIsLikedWrapped: Decodable {
    var response: LikesIsLikedResponse
}

struct LikesIsLikedResponse: Decodable {
    var liked: Int
    var copied: Int
}
