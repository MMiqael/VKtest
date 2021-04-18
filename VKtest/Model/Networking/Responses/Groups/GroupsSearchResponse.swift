//
//  GroupsSearchResponse.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 09.02.2021.
//

import Foundation
//import RealmSwift

struct GroupsSearchResponse: Decodable {
    var response: GroupsSearchResponseResults
}

struct GroupsSearchResponseResults: Decodable {
    var count: Int
    var items: [GroupsSearch]
}

struct GroupsSearch: Decodable {
//    @objc dynamic var id = 0
//    @objc dynamic var name = ""
//    @objc dynamic var screenName = ""
//    @objc dynamic var photo50 = ""
//    @objc dynamic var isMember = 0
    
    var id: Int
    var name: String
    var screenName: String
    var photo50: String
    var isMember: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case isMember = "is_member"
    }
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
}
