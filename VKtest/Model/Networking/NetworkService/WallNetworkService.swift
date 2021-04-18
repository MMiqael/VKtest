//
//  WallNetworkService.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 12.02.2021.
//

import Alamofire
import RealmSwift

class WallNetworkService {
    
    let baseUrl = "https://api.vk.com/method/wall"
    let session = Session.shared
    let version = "5.126"
    
    // MARK: .get
    func get() {
        
        let path = ".get"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "count": 5,
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { /*[weak self]*/ response in
            guard let data = response.value else { return print("data error") }
            print("Response: \(response)")
            print("Data: \(data)")
        
            do {
                let items = try JSONDecoder().decode(WallGetResponse.self, from: data).response.items
                print("Items: \(items)")
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: saveWallData
    func saveWallData() {
        
    }
}
