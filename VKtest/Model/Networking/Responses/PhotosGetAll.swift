//
//  PhotoGetAll.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 10.01.2021.
//

import Foundation
//import RealmSwift

struct PhotosGetAllResponse: Decodable {
    let response: PhotosGetAllResults
}

struct PhotosGetAllResults: Decodable {
    let count: Int
    let items: [PhotosGetAllItems]
}

struct PhotosGetAllItems: Decodable {
//    @objc dynamic var id = 0
//    @objc dynamic var url = ""
    
    var id: Int
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case sizes
    }

    enum SizesCodingKeys: String, CodingKey {
        case url
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)

        var sizesValues = try values.nestedUnkeyedContainer(forKey: .sizes)
        let urlValues = try sizesValues.nestedContainer(keyedBy: SizesCodingKeys.self)
        self.url = try urlValues.decode(String.self, forKey: .url)
    }
    
//    override static func primaryKey() -> String? {
//        return "url"
//    }
}
