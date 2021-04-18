//
//  LikesNetworkService.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 26.02.2021.
//

import Foundation
import Alamofire

class LikesNetworkService {
    
    let baseUrl = "https://api.vk.com/method/likes"
    let session = Session.shared
    let version = "5.126"
    
    func isLiked(ownerId: Int, itemId: Int, completion: @escaping (LikesIsLikedResponse) -> Void) {
        
        let path = ".isLiked"
        let url = baseUrl + path
        
        let ownerId = ownerId
        let itemId = itemId
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "type": "post",
            "owner_id": ownerId,
            "item_id": itemId,
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            
            do {
                let likes = try JSONDecoder().decode(LikesIsLikedWrapped.self, from: data).response
                
                completion(likes)
            } catch {
                print(error)
            }
        }
    }
}
