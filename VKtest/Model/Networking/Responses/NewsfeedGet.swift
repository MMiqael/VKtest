//
//  NewsfeedGet.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 11.02.2021.
//

import Foundation
//import RealmSwift

struct NewsfeedGetWrapper: Decodable {
    let response: NewsfeedGetResponse
}

struct NewsfeedGetResponse: Decodable {
    let items: [NewsfeedGetItems]
    let profiles: [NewsfeedGetProfiles]
    let groups: [NewsfeedGetGroups]
}

struct NewsfeedGetItems: Decodable {
    var sourceId: Int
    var date: Double
    var postId: Int
    var text: String
    var attachments: [Attachments]?
    var comments: CountableItem
    var likes: CountableItem
    var reposts: CountableItem
    var views: CountableItem

    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case postId = "post_id"
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        sourceId = try value.decode(Int.self, forKey: .sourceId)
        date = try value.decode(Double.self, forKey: .date)
        postId = try value.decode(Int.self, forKey: .postId)
        text = try value.decode(String.self, forKey: .text)
        attachments = try value.decodeIfPresent([Attachments].self, forKey: .attachments)
        comments = try value.decode(CountableItem.self, forKey: .comments)
        likes = try value.decode(CountableItem.self, forKey: .likes)
        reposts = try value.decode(CountableItem.self, forKey: .reposts)
        views = try value.decode(CountableItem.self, forKey: .views)
    }

    struct Attachments: Decodable {
        var type: String
        var photo: Photo?
////        var link: Link?
//
        struct Photo: Decodable {
            var sizes: [Sizes]?

            struct Sizes: Decodable {
                var url: String
            }
        }
        
//        struct Link: Decodable {
//            var photo: LinkPhoto
//
//            struct LinkPhoto: Decodable {
//                var sizes: [Sizes]
//
//                struct Sizes: Decodable {
//                    var url: String
//                }
//            }
//        }
    }

    struct CountableItem: Decodable {
        var count: Int
    }
}

struct NewsfeedGetProfiles: Decodable {
    var firstName: String
    var id: Int
    var lastName: String
//    var screenName: String
    var photo50: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
//        case screenName = "screen_name"
        case photo50 = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try value.decode(String.self, forKey: .firstName)
        id = try value.decode(Int.self, forKey: .id)
        lastName = try value.decode(String.self, forKey: .lastName)
//        screenName = try value.decode(String.self, forKey: .screenName)
        photo50 = try value.decode(String.self, forKey: .photo50)
    }
}

struct NewsfeedGetGroups: Decodable {
    var id: Int
    var name: String
//    var screenName: String
//    var isClosed: Int
//    var type: String
//    var isMember: Int
    var photo50: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
//        case screenName = "screen_name"
//        case isClosed = "is_closed"
//        case type
//        case isMember = "is_member"
        case photo50 = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        name = try value.decode(String.self, forKey: .name)
//        screenName = try value.decode(String.self, forKey: .screenName)
//        isClosed = try value.decode(Int.self, forKey: .isClosed)
//        type = try value.decode(String.self, forKey: .type)
//        isMember = try value.decode(Int.self, forKey: .isMember)
        photo50 = try value.decode(String.self, forKey: .photo50)
    }
}



















//class NewsfeedGetProfiles: Object, Decodable {
//    @objc dynamic var firstName = ""
//    @objc dynamic var id = 0
//    @objc dynamic var lastName = ""
//    @objc dynamic var screenName = ""
//    @objc dynamic var photo50 = ""
//    @objc dynamic var photo100 = ""
//
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case id
//        case lastName = "last_name"
//        case screenName = "screen_name"
//        case photo50 = "photo_50"
//        case photo100 = "photo_100"
//    }
//
//    override class func primaryKey() -> String? {
//        return "id"
//    }
//}
//
//class NewsfeedGetGroups: Object, Decodable {
//    @objc dynamic var id = 0
//    @objc dynamic var name = ""
//    @objc dynamic var screenName = ""
//    @objc dynamic var type = ""
//    @objc dynamic var isMember = 0
//    @objc dynamic var photo50 = ""
//    @objc dynamic var photo100 = ""
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case screenName = "screen_name"
//        case type
//        case isMember = "is_member"
//        case photo50 = "photo_50"
//        case photo100 = "photo_100"
//    }
//
//    override class func primaryKey() -> String? {
//        return "id"
//    }
//}
