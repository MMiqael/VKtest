//
//  TestNewsfeed.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 24.02.2021.
//

import Foundation
import UIKit

struct PostNews {
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

struct NewsResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var items: [Item]
        var groups: [Groups]
        var profiles: [Profiles]
        
        struct Item: Decodable {
            var sourceID: Int
            var date: Double
            var text: String
            var likes: Likes
            var comments: Comments
            var reposts: Reposts
            var views: Views
            var attachments: [Attachments]?
            
            private enum CodingKeys: String, CodingKey {
                case sourceID = "source_id"
                case date
                case text
                case likes
                case comments
                case reposts
                case views
                case attachments
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                sourceID = try container.decode(Int.self, forKey: .sourceID)
                date = try container.decode(Double.self, forKey: .date)
                text = try container.decode(String.self, forKey: .text)
                likes = try container.decode(Likes.self, forKey: .likes)
                comments = try container.decode(Comments.self, forKey: .comments)
                reposts = try container.decode(Reposts.self, forKey: .reposts)
                views = try container.decode(Views.self, forKey: .views)
                attachments = try container.decodeIfPresent([Attachments].self, forKey: .attachments)
            }
            
            struct Likes: Decodable {
                var count: Int
            }
            
            struct Comments: Decodable {
                var count: Int
            }
            
            struct Reposts: Decodable {
                var count: Int
            }
            
            struct Views: Decodable {
                var count: Int
            }
            
            struct Attachments: Decodable {
                var type: String
                var photo: Photo?
                var link: Link?
                
                struct Photo: Decodable {
                    var sizes: [Sizes]
                    
                    struct Sizes: Decodable {
                        var url: String
                    }
                }
                
                struct Link: Decodable {
                    var photo: LinkPhoto
                    
                    struct LinkPhoto: Decodable {
                        var sizes: [Sizes]
                        
                        struct Sizes: Decodable {
                            var url: String
                        }
                    }
                }
            }
        }
        
        struct Groups: Decodable {
            var id: Int
            var name: String
            var avatar: String
            
            private enum CodingKeys: String, CodingKey {
                case id
                case name
                case avatar = "photo_50"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                id = try container.decode(Int.self, forKey: .id)
                name = try container.decode(String.self, forKey: .name)
                avatar = try container.decode(String.self, forKey: .avatar)
            }
        }
        
        struct Profiles: Decodable {
            var id: Int
            var firstName: String
            var lastName: String
            var avatar: String
            
            private enum CodingKeys: String, CodingKey {
                case id
                case firstName = "first_name"
                case lastName = "last_name"
                case avatar = "photo_50"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                id = try container.decode(Int.self, forKey: .id)
                firstName = try container.decode(String.self, forKey: .firstName)
                lastName = try container.decode(String.self, forKey: .lastName)
                avatar = try container.decode(String.self, forKey: .avatar)
            }
        }
    }
}

class GetNewsList {
    
    //данные для авторизации в ВК
    func loadData(complition: @escaping ([PostNews]) -> Void ) {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        guard let ownerId = Session.shared.userId else { return }
        guard let token = Session.shared.token else { return }
        print("Owner id: \(ownerId)")
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/newsfeed.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: ownerId),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "filters", value: "post,photo"),
            //URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "v", value: "5.122")
        ]
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            //print("Запрос к API: \(urlConstructor.url!)")
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data else { return }
            
            do {
                let arrayNews = try JSONDecoder().decode(NewsResponse.self, from: data)
                
                guard arrayNews.response.items.isEmpty == false else { return } // проверка на наличие новостей
                
                var avatar: String = ""
                var name: String = ""
                var strDate: String
                var text: String
                var urlImg: String = ""
                
                var newsList: [PostNews] = []
                
                for i in 0...arrayNews.response.items.count-1 {
                    let typeNews = arrayNews.response.items[i].attachments?.first?.type
                    guard typeNews != "link" || typeNews != "photo" else { return } //проверка типа новостей, отрабатываем только два варианта
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let date = Date(timeIntervalSince1970: arrayNews.response.items[i].date)
                    strDate = dateFormatter.string(from: date)
                    
                    text = arrayNews.response.items[i].text
                    
                    if typeNews == "link" {
                        urlImg = arrayNews.response.items[i].attachments?.first?.link?.photo.sizes.first?.url ?? ""
                    }
                    if typeNews == "photo" {
                        urlImg = arrayNews.response.items[i].attachments?.first?.photo?.sizes.last?.url ?? ""
                    }
                    
                    let likes = arrayNews.response.items[i].likes.count
                    let comments = arrayNews.response.items[i].comments.count
                    let reposts = arrayNews.response.items[i].reposts.count
                    let views = arrayNews.response.items[i].views.count
                    
                    
                    // имена и аватарки групп
                    // много вложенных циклов!
                    let sourceID = arrayNews.response.items[i].sourceID * -1
                    for i in 0...arrayNews.response.groups.count-1 {
                        if arrayNews.response.groups[i].id == sourceID {
                            name = arrayNews.response.groups[i].name
                            avatar = arrayNews.response.groups[i].avatar
                        }
                    }
                    
                    newsList.append(PostNews(name: name, avatar: avatar, date: strDate, textNews: text, imageNews: urlImg, likes: likes, comments: comments, reposts: reposts, views: views))
                }
                print("newsList: \(newsList)")
                return complition(newsList)
                
            } catch let error {
                print(error)
                complition([])
            }
        }
        task.resume()
    }
    
}







//AF.request(url, method: .get, parameters: params).responseData { /*[weak self]*/ response in
//    guard let data = response.value else { return print("data error") }
//
//    do {
//        let news = try JSONDecoder().decode(NewsfeedGetResponse.self, from: data)
//
//        guard news.response.items.isEmpty == false else { return }
//
//        var avatar: String = ""
//        var name: String = ""
//        var strDate: String
//        var text: String
//        var urlImg: String = ""
//
//        var newsList: [NewsfeedStruct] = []
//
//        for i in 0...news.response.items.count - 1 {
//            let newsType = news.response.items[i].attachments?.first?.type
//            guard newsType != "link" || newsType != "photo" else { return }
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//            let date = Date(timeIntervalSince1970: news.response.items[i].date)
//            strDate = dateFormatter.string(from: date)
//
//            text = news.response.items[i].text
//
//            if newsType == "photo" {
//                urlImg = news.response.items[i].attachments?.first?.photo?.sizes?.first?.url ?? ""
//            } else if newsType == "link" {
//                urlImg = news.response.items[i].attachments?.first?.link?.photo.sizes.first?.url ?? ""
//            }
//
//            let commets = news.response.items[i].comments.count
//            let like = news.response.items[i].likes.count
//            let reposts = news.response.items[i].reposts.count
//            let view = news.response.items[i].views.count
//
//            let sourceId = news.response.items[i].sourceId * -1
//            for i in 0...news.response.groups.count - 1 {
//                if news.response.groups[i].id == sourceId {
//                    name = news.response.groups[i].name
//                    avatar = news.response.groups[i].photo50
//                }
//            }
//
//            newsList.append(NewsfeedStruct(name: name, avatar: avatar, date: strDate, textNews: text, imageNews: urlImg, likes: like, comments: commets, reposts: reposts, views: view))
//        }
//        return completion(newsList)
//
//    } catch {
//        print(error)
//        completion([])
//    }
//}
