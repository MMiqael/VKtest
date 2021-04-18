//
//  ProfileFriendsCell.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 08.02.2021.
//

import UIKit
//import RealmSwift
import Alamofire

class ProfileFriendsCell: UITableViewCell {
    
//    var friends = [FriendsGetItems]() // Results<FriendsGetItems>?
//    static var friendsCount = 0
    private let friendsNetworkService = FriendsNetworkService()

    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    
    @IBOutlet weak var profileFriendsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileFriendsCollectionView.delegate = self
        profileFriendsCollectionView.dataSource = self
        
//        loadData()
        
//        friendsNetworkService.get { [weak self] response in
//    //            self?.loadData()
//            self?.friends = response.items
//            ProfileController.friendsCount = response.count
////            print("Friends in cell: \(String(describing: self?.friends))")
//            DispatchQueue.main.async {
//                self?.profileFriendsCollectionView.reloadData()
//            }
//        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func showFriendsButton(_ sender: Any) {
    }
    
//    func loadData() {
//        do {
//            let realm = try Realm()
//            let results = realm.objects(FriendsGetItems.self)
//            friends = Array(results)
////            reloadInputViews()
//        } catch {
//            print(error)
//        }
//    }
}

extension ProfileFriendsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1//friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnumReuseIdentifiers.profileFriendsCollectionCell.rawValue, for: indexPath) as? ProfileFriendsCollectionCell else { fatalError("Unable to creare explore table view cell") }
        
        
//        cell.firstNameLabel.text = friends[indexPath.row].firstName
//        cell.lastNameLabel.text = friends[indexPath.row].lastName
//
//        if let url = URL(string: friends[indexPath.row].photo50) {
//            AF.download(url, method: .get).responseData { response in
//                guard let data = response.value else { return }
//                let avatar = UIImage(data: data)
//                DispatchQueue.main.async {
//                    cell.avatar.image = avatar
//                    cell.avatar.layer.cornerRadius = cell.avatar.frame.size.width / 2
//                    cell.avatar.clipsToBounds = true
//                    cell.avatar.contentMode = .scaleAspectFill
//                    cell.avatar.translatesAutoresizingMaskIntoConstraints = false
//                }
//            }
//        }
        return cell
    }
}
