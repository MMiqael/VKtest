//
//  UsersGet.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 09.02.2021.
//

import Foundation
//import RealmSwift

//struct UsersGetResponse: Decodable {
//    let response: [UsersGetResults]
//}

struct UsersGetResults: Decodable {
//    @objc dynamic var firstName = ""
//    @objc dynamic var id = 0
//    @objc dynamic var lastName = ""
//    @objc dynamic var photo100 = ""
//    @objc dynamic var sex = 0
//    @objc dynamic var bdate = ""
//    @objc dynamic var screenName = ""
//    @objc dynamic var fullName: String {
//        return "\(firstName) \(lastName)"
//    }
    
    var firstName: String
    var id: Int
    var lastName: String
    var canAccessClosed: Bool
    var isClosed: Bool
    var photo100: String
    var sex: Int
    var bdate: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
//    var photo100: String
//    var sex: Int
//    var bdate: String
//    var screenName: String
//    var fullName: String {
//        return "\(firstName) \(lastName)"
//    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case photo100 = "photo_100"
        case sex
        case bdate
//        case photo100 = "photo_100"
//        case sex
//        case bdate
//        case screenName = "screen_name"
    }

//    override class func primaryKey() -> String? {
//        return "id"
//    }
}




























//    required convenience init(from decoder: Decoder) throws {
//        self.init()
//
//        let value = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try value.decode(Int.self, forKey: .id)
//        self.firstName = try value.decode(String.self, forKey: .firstName)
//        self.lastName = try value.decode(String.self, forKey: .lastName)
//        self.photo100 = try value.decode(String.self, forKey: .photo100)
//        self.sex = try value.decode(Int.self, forKey: .sex)
//        self.screenName = try value.decode(String.self, forKey: .screenName)
//    }
