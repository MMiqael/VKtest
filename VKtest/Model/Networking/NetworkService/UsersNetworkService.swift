//
//  UsersNetworkService.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 12.02.2021.
//

import Alamofire
//import RealmSwift

class UsersNetworkService {
    
    let baseUrl = "https://api.vk.com/method/users"
    let session = Session.shared
    let version = "5.126"
    
    // MARK: .get
    func get(completion: @escaping ([UsersGetResults]) -> Void) {
        
        let path = ".get"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "fields": "photo_100, sex, bdate, screen_name",
//            "user_ids": "144992182",
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { /*[weak self]*/ response in
            guard let data = response.value else { return print("get users data error") }
            
            do {
                let users = try JSONDecoder().decode([UsersGetResults].self, from: data)
                print("Users: \(users)")
//                DispatchQueue.main.async {
//                    self?.saveUsersData(users)
//                }
                completion(users)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: saveUsersData
//    func saveUsersData(_ users: [UsersGetResults]) {
//        do {
//            var config = Realm.Configuration.defaultConfiguration
//            config.deleteRealmIfMigrationNeeded = true
//
//            let realm = try Realm(configuration: config)
//            let oldValues = realm.objects(UsersGetResults.self)
//            realm.beginWrite()
//            realm.delete(oldValues)
//            realm.add(users, update: .modified)
//            try realm.commitWrite()
//
//            print(realm.configuration.fileURL!)
//        } catch {
//            print(error)
//        }
//    }
}


