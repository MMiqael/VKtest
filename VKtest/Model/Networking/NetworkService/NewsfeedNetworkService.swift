//
//  NewsfeedNetworkService.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 12.02.2021.
//

import Alamofire
//import RealmSwift

struct NewsStruct {
    var name: String
    var avatar: String
    var date: String
    var textNews: String
    var imageNews: String
    var likes: Int
    var comments: Int
    var reposts: Int
    var views: Int
}

class NewsfeedNetworkService {
    
    let baseUrl = "https://api.vk.com/method/newsfeed"
    let session = Session.shared
    let version = "5.126"
    
    // MARK: .get
    func get(completion: @escaping ([NewsStruct]) -> Void) {
        
        let path = ".get"
        let url = baseUrl + path
        
        guard let token = session.token else { return }
        
        let params: Parameters = [
            "filters": "post",
            "access_token": token,
            "v": version
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { /*[weak self]*/ response in
            guard let data = response.value else { return print("data error") }

            do {
                let news = try JSONDecoder().decode(NewsfeedGetWrapper.self, from: data).response
//                print("News: \(news)")
                
                var name: String = ""
                var avatar: String = ""
                var strDate: String
                var text: String
                var imgUrl = ""
                
                var newsArray: [NewsStruct] = []
                
                for i in 0...news.items.count - 1 {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "d EEE y, HH:mm"
                    let date = Date(timeIntervalSince1970: news.items[i].date)
                    strDate = dateFormatter.string(from: date)
                    
                    text = news.items[i].text
                    
//                    let typeNews = arrayNews.response.items[i].attachments?.first?.type
//
//                    if typeNews == "photo"
//                    imgUrl = news.items[i].attachments?.photo?.sizes?.first?.url ?? ""
                    
//                    news.items[i].attachments?[i].photo?.sizes?.first?.url
                    
                    
                    let comments = news.items[i].comments.count
                    let likes = news.items[i].likes.count
                    let reposts = news.items[i].reposts.count
                    let views = news.items[i].views.count
                    
                    let sourceId = news.items[i].sourceId * -1
                    for i in 0...news.groups.count - 1 {
                        if news.groups[i].id == sourceId {
                            name = news.groups[i].name
                            avatar = news.groups[i].photo50
                        }
                    }
                    newsArray.append(NewsStruct(name: name, avatar: avatar, date: strDate, textNews: text, imageNews: imgUrl, likes: likes, comments: comments, reposts: reposts, views: views))
                }
                
                completion(newsArray)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: saveNewsfeedData
//    func saveNewsfeedData(_ newsfeed: [NewsfeedGetItems]) {
//        do {
////            var config = Realm.Configuration.defaultConfiguration
////            config.deleteRealmIfMigrationNeeded = true
//
//            let realm = try Realm(/*configuration: config*/)
//            let oldValue = realm.objects(NewsfeedGetItems.self)
//            realm.beginWrite()
//            realm.delete(oldValue)
//            realm.add(newsfeed, update: .modified)
//            try realm.commitWrite()
//
//            print(realm.configuration.fileURL!)
//        } catch {
//            print(error)
//        }
//    }
}





