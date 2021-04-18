//
//  AccountGetProfileInfo.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 09.02.2021.
//

import Foundation
import RealmSwift

struct AccountGetProfileInfoResponse: Decodable {
    let response: AccountGetProfileInfoResults
}

class AccountGetProfileInfoResults: Object, Decodable {
    @objc dynamic var firstName = ""
    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    @objc dynamic var screenName = ""
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case screenName = "screen_name"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
