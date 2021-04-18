//
//  NewsfeedController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 28.11.2020.
//

import UIKit
import Alamofire
//import RealmSwift

class NewsfeedController: UITableViewController {
    
//    var newsItems: [NewsfeedGetItems] = [] // Results<NewsfeedGetItems>?
//    var newsProfile: [NewsfeedGetProfiles] = []
//    var newsGroups: [NewsfeedGetGroups] = []
    let newsfeedNetworkService = NewsfeedNetworkService()
    
    var news: [NewsStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        navigationItem.title = "Новости"
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        loadData()
        
        DispatchQueue.global().async {
            self.newsfeedNetworkService.get { [weak self] response in
                //            self?.newsItems = response.items
                //            self?.newsProfile = response.profiles
                //            self?.newsGroups = response.groups
                self?.news = response
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
//    func loadData() {
//        do {
//            let realm = try Realm()
//            let results = realm.objects(NewsfeedGetItems.self)
//            print(results)
//            news = results
//            tableView.reloadData()
//        } catch {
//            print(error)
//        }
//    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.newsFeedCell.rawValue, for: indexPath) as? NewsfeedCell else {fatalError("Unable to creare explore table view cell")}
        
        if let avatarUrl = URL(string: news[indexPath.row].avatar) {
            DispatchQueue.global().async {
                AF.download(avatarUrl, method: .get).responseData { response in
                    guard let data = response.value else { return }
//                    print("GLOBAL")
                    DispatchQueue.main.async {
                        let avatar = UIImage(data: data)
                        cell.avatar.image = avatar
                        cell.avatar.layer.cornerRadius = cell.avatar.frame.size.width / 2
                        cell.avatar.clipsToBounds = true
                        cell.avatar.contentMode = .scaleAspectFill
                        cell.avatar.translatesAutoresizingMaskIntoConstraints = false
//                        print("MAIN")
                    }
                }
            }
        }
        
        cell.nameLabel.text = news[indexPath.row].name
        cell.timeLabel.text = news[indexPath.row].date
        
        cell.messageTextView.text = news[indexPath.row].textNews
        cell.pictureImageView.image = UIImage(systemName: "person")
        
        cell.likeControl.count.text = String(news[indexPath.row].likes)
        cell.likeControl.likesCount = news[indexPath.row].likes
        cell.commentsControl.count.text = String(news[indexPath.row].comments)
        cell.repostsControl.count.text = String(news[indexPath.row].reposts)
        cell.viewsControl.count.text = String(news[indexPath.row].views)
        
//        if let imageUrl = URL(string: news[indexPath.row].imageNews) {
//            AF.download(imageUrl, method: .get).responseData { response in
//                guard let data = response.value else { return }
//                let image = UIImage(data: data)
//                DispatchQueue.main.async {
//                    cell.pictureImageView.image = image
//                }
//            }
//        }
        
        cell.backgroundColor = .systemBackground
        cell.separatorView.backgroundColor = .systemGray5

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension

//extension NewsFeedController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnumReuseIdentifiers.newsImageCell.rawValue, for: indexPath) as! NewsImageCell
//        
//        cell.pictureImageView.image = UIImage(named: news[indexPath.row].picture)
//        
//        return cell
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let frameCV = collectionView.frame
//        let widthCell = frameCV.width
//        
//        let image = UIImage(named: news[indexPath.row].picture)
//        let widthImage = image!.size.width
//        let heightImage = image!.size.height
//        
//        func resize(_ widthCell: CGFloat, _ widthImage: CGFloat, _ heightImage: CGFloat) -> CGFloat {
//            let widthDifference = widthImage / widthCell
//            let heightCell = heightImage / widthDifference
//            return heightCell
//        }
//        
//        let heightCell = resize(widthCell, widthImage, heightImage)
//        
//        return CGSize(width: widthCell, height: heightCell)
//    }
//}
