//
//  WallGet.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 12.02.2021.
//

import Foundation
import RealmSwift

struct WallGetResponse: Decodable {
    let response: WallGetResults
}

struct WallGetResults: Decodable {
    var count: Int
    var items: [WallGetItems]
}

class WallGetItems: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var fromId = 0
    @objc dynamic var ownerId = 0
    @objc dynamic var date = 0
    @objc dynamic var postType = ""
    @objc dynamic var text = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fromId = "from_id"
        case ownerId = "owner_id"
        case date = "date"
        case postType = "post_type"
        case text = "text"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
