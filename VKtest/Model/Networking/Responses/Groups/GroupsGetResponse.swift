//
//  GroupsGetResponse.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 19.11.2020.
//

import Foundation
//import RealmSwift

struct GroupsGetResponse: Decodable {
    let response: GroupsGetResponseResults
}

struct GroupsGetResponseResults: Decodable {
    let count: Int
    let items: [GroupsGet]
}

struct GroupsGet: Decodable {
    
//    @objc dynamic var id = 0
//    @objc dynamic var name = ""
//    @objc dynamic var photo50 = ""
//    @objc dynamic var screenName = ""
//    @objc dynamic var isClosed = 0
//    @objc dynamic var isMember = 0
    
    var id: Int
    var name: String
    var photo50: String
    var screenName: String
    var isClosed: Int
    var isMember: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo50 = "photo_50"
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case isMember = "is_member"
    }
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}

//extension Group: Equatable {
//    static func == (lhs: Group, rhs: Group) -> Bool {
//        return lhs.name == rhs.name
//    }
//}
