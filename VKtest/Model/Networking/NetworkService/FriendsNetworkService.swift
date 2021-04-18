//
//  FriendsNetworkService.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 11.02.2021.
//

import Alamofire
//import RealmSwift

protocol NetworkServiceProtocol {
    func get(completion: @escaping (FriendsGetResults) -> Void)
}

class ProxyFriendsNetworkService: NetworkServiceProtocol {
    
    let friendsNetworkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        friendsNetworkService = networkService
    }
    
    func get(completion: @escaping (FriendsGetResults) -> Void) {
        self.friendsNetworkService.get(completion: completion)
        print("\(Date()) called method .get for Friends")
    }
}

class FriendsNetworkService: NetworkServiceProtocol {
    
    let baseUrl = "https://api.vk.com/method/friends"
    let session = Session.shared
    let version = "5.126"

    // MARK: .get
    func get(completion: @escaping (FriendsGetResults) -> Void) {
        
        let path = ".get"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "order": "hints",
            "fields": "photo_50",
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { /*[weak self]*/ response in
            guard let data = response.value else { return print("get friends data error") }
            
            do {
                let friends = try JSONDecoder().decode(FriendsGetResponse.self, from: data).response
//                print(friends.items)
//                DispatchQueue.main.async {
//                    self?.saveFriendsData(items)
//                }
                completion(friends)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: saveFriendsData
//    func saveFriendsData(_ friends: [FriendsGetItems]) {
//        do {
//            var config = Realm.Configuration.defaultConfiguration
//            config.deleteRealmIfMigrationNeeded = true
//
//            let realm = try Realm(configuration: config)
//            let oldValues = realm.objects(FriendsGetItems.self)
//            realm.beginWrite()
//            realm.delete(oldValues)
//            realm.add(friends, update: .modified)
//            try realm.commitWrite()
//
//            print(realm.configuration.fileURL!)
//        } catch {
//            print(error)
//        }
//    }
}




