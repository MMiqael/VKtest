//
//  GroupsNSAdapter.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 14.04.2021.
//

import Foundation
import Alamofire

protocol GroupsNSAdapterProtocol {
    func get(completion: @escaping (GroupsGetResponseResults) -> Void)
    func join(groupId: Int)
    func leave(groupId: Int)
    func search(by name: String, completion: @escaping (GroupsGetResponseResults) -> Void)
}

class GroupsNSAdapter: GroupsNSAdapterProtocol {
    
    let baseUrl = "https://api.vk.com/method/groups"
    let session = Session.shared
    let version = "5.126"
    
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
    
}
