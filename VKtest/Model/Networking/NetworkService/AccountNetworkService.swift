//
//  AccountNetworkService.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 12.02.2021.
//

import Alamofire
//import RealmSwift

class AccountNetworkService {
    
    let baseUrl = "https://api.vk.com/method/account"
    let session = Session.shared
    let version = "5.126"
    
    
    // MARK: .getProfileInfo
    func getProfileInfo() {
        let path = ".getProfileInfo"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { /*[weak self]*/ response in
            guard let data = response.value else { return print("data error") }
            do {
                let profileInfo = try JSONDecoder().decode(AccountGetProfileInfoResponse.self, from: data).response
                print(profileInfo)
//                self?.saveAccountGetProfileInfo(profileInfo)
            } catch {
                print(error)
            }
        }
    }

    
    // MARK: saveAccountGetProfileInfo
//    func saveAccountGetProfileInfo(_ profileInfo: AccountGetProfileInfoResults) {
//        do {
////            var config = Realm.Configuration.defaultConfiguration
////            config.deleteRealmIfMigrationNeeded = true
//
//            let realm = try Realm(/*configuration: config*/)
//            let oldValues = realm.objects(AccountGetProfileInfoResults.self)
//            realm.beginWrite()
//            realm.delete(oldValues)
//            realm.add(profileInfo)
//            try realm.commitWrite()
//
//            print(realm.configuration.fileURL!)
//        } catch {
//            print(error)
//        }
//    }
}
