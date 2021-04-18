//
//  GroupsNetworkService.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 11.02.2021.
//

import Alamofire
//import RealmSwift

class GroupsNetworkService {
    
    let baseUrl = "https://api.vk.com/method/groups"
    let session = Session.shared
    let version = "5.126"
    
    // MARK: .get
    func get(completion: @escaping (GroupsGetResponseResults) -> Void) {
        
        let path = ".get"
        let url = baseUrl + path
        
        guard  let token = session.token else { return }
        
        let params: Parameters = [
            "extended": 1,
            "fields": "name, photo_50",
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { /*[weak self]*/ response in
            guard let data = response.value else { return print("data error") }
            do {
                let groupsGetResponseResults = try JSONDecoder().decode(GroupsGetResponse.self, from: data).response
//                self?.saveGroupsData(groups)
                completion(groupsGetResponseResults)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: .join
    func join(groupId: Int) {
        
        let path = ".join"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "group_id": groupId,
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return print("data error") }
            do {
                _ = try JSONDecoder().decode(GroupsJoinResponse.self, from: data).response
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: .leave
    func leave(groupId: Int) {
        
        let path = ".leave"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "group_id": groupId,
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return print("data error") }
            do {
                _ = try JSONDecoder().decode(GroupsLeaveResponse.self, from: data).response
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: .search
    func search(by name: String, completion: @escaping (GroupsGetResponseResults) -> Void) {
        
        let path = ".search"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "q": name,
            "sort": 0,
            "count": 150,
            "access_token": token,
            "v": version
        ]
                
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return print("data error") }
            do {
                let groups = try JSONDecoder().decode(GroupsGetResponse.self, from: data).response
                completion(groups)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: saveGroupsData
//    func saveGroupsData(_ groups: [GroupsGet]) {
//        do {
////            var config = Realm.Configuration.defaultConfiguration
////            config.deleteRealmIfMigrationNeeded = true
//
//            let realm = try Realm(/*configuration: config*/)
//            let oldValues = realm.objects(GroupsGet.self)
//            realm.beginWrite()
//            realm.delete(oldValues)
//            realm.add(groups, update: .modified)
//            try realm.commitWrite()
//
//            print(realm.configuration.fileURL!)
//        } catch {
//            print(error)
//        }
//    }
}
