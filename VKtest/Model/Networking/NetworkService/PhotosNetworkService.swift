//
//  PhotosNetworkService.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 12.02.2021.
//

import Alamofire
//import RealmSwift

class PhotosNetworkService {
    
    let baseUrl = "https://api.vk.com/method/photos"
    let session = Session.shared
    let version = "5.126"
    
    // MARK: .getAll
    func getAll(ownerId: Int, completion: @escaping ([PhotosGetAllItems]) -> Void) {
        
        let path = ".getAll"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "owner_id": ownerId,
            "count": 200,
            "access_token": token,
            "v": version
        ]
        AF.request(url, method: .get, parameters: params).responseData { /*[weak self]*/ response in
            guard let data = response.value else { return print("data error") }
            do {
                let photos = try JSONDecoder().decode(PhotosGetAllResponse.self, from: data).response.items
//                self?.savePhotosData(photos)
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: переделать!
//    func getLargeSizePhotos(/*id: Int,*/ completion: @escaping ([Photo]) -> Void) {
//
//        let path = ".getAll"
//        let url = baseUrl + path
//
//        guard let token = session.token else { return }
//
//        let params: Parameters = [
////            "id": id,
////            "extended": 1,
////            "photo_sizes": 1,
//            "access_token": token,
//            "v": version
//        ]
//
//        AF.request(url, method: .get, parameters: params).responseData { response in
//            guard let data = response.value else { return print("data error") }
//            do {
//                let photo = try JSONDecoder().decode(PhotoResponse.self, from: data).response.items
//                completion(photo)
//            } catch {
//                print(error)
//            }
//        }
//    }
    
    // MARK: savePhotosData
//    func savePhotosData(_ photos: [PhotosGetAllItems]) {
//        do {
////            var config = Realm.Configuration.defaultConfiguration
////            config.deleteRealmIfMigrationNeeded = true
//
//            let realm = try Realm(/*configuration: config*/)
//            let oldValues = realm.objects(PhotosGetAllItems.self)
//            realm.beginWrite()
//            realm.delete(oldValues)
//            realm.add(photos, update: .modified)
//            try realm.commitWrite()
//
//            print(realm.configuration.fileURL!)
//        } catch {
//            print(error)
//        }
//    }
}
