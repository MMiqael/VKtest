//
//  ProfileController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 08.02.2021.
//

import UIKit
//import RealmSwift
import FirebaseAuth
import Alamofire

class ProfileController: UITableViewController {
    
//    private var friendsCount: Int?
    private var profileItems: [UsersGetResults] = [] // Results<UsersGetResults>?
    let usersNetworkService = UsersNetworkService()
//    let friendsNetworkService = FriendsNetworkService()
//    var friendsCount = 0
//    let profileFriendsCell = ProfileFriendsCell()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
//        loadData()
        
//        friendsNetworkService.get { [weak self] count in
////            self?.friendsCount = count
//            self?.tableView.reloadData()
//        }
        
        usersNetworkService.get { [weak self] response in
//            self?.loadData()
            DispatchQueue.main.async {
            self?.profileItems = response
            print("Response: \(response)")
            print("ProfileItems?: \(String(describing: self?.profileItems))")
                self?.tableView.reloadData()
            }
        }
        print("ProfileItems: \(profileItems)")
        
//        friendsNetworkService.get { [weak self] response in
//            self?.friendsCount = response.count
//            self?.profileFriendsCell.friends = response.items
//        }
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch (let error) {
            print(error)
        }
    }
    
//    func loadData() {
//        do {
//            let realm = try Realm()
//            let results = realm.objects(UsersGetResults.self)
//            print(results)
//            users = Array(results)
//            print(users)
////            DispatchQueue.main.async {
////                self.tableView.reloadData()
////            }
//        } catch {
//            print(error)
//        }
//    }
    
    func addTitle(_ title: String) {
        navigationItem.title = title
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        case 1:
//            return 1
//        case 2:
//            return 1
//        default:
//            return 1
//        }
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        print(profileItems[indexPath.row])
//        print("ProfileItems: \(profileItems)")
//        print("Index: \(profileItems[indexPath.row])")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.profileHeaderCell.rawValue, for: indexPath) as! ProfileHeaderCell
        
        cell.nameLabel.text = profileItems[indexPath.row].fullName
        
        if let url = URL(string: profileItems[indexPath.row].photo100) {
            DispatchQueue.global().async {
                AF.download(url, method: .get).responseData { response in
                    guard let data = response.value else { return }
                    DispatchQueue.main.async {
                        let avatar = UIImage(data: data)
                        cell.avatar.image = avatar
                    }
                }
            }
        }
        
        return cell
        
//        switch indexPath.row {
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.profileHeaderCell.rawValue, for: indexPath) as? ProfileHeaderCell else { fatalError() }
//
//            cell.nameLabel.text = profileItems[indexPath.row].fullName
//            cell.avatar.image = UIImage(systemName: "person")
//            print("Case 0")
//
//            return cell
//        case 1:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.profileInfoCell.rawValue, for: indexPath) as? ProfileInfoCell else { fatalError() }
//
//            cell.cityLabel.text = "Moscow"
//            cell.bdLabel.text = "1"//profileItems[indexPath.row].bdate
//            cell.sexLabel.text = "male"
//            print("Case 1")
//
//            return cell
//        case 2:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.profileFriendsCell.rawValue, for: indexPath) as? ProfileFriendsCell else { fatalError() }
//
//            cell.friendsCountLabel.text = "111"//"\(friendsCount)"
//
//            return cell
//        default:
//            return UITableViewCell()
//        }
        
                
//        addTitle(profileItems[indexPath.row].screenName)
//
//        switch indexPath.section {
//
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.profileHeaderCell.rawValue, for: indexPath) as? ProfileHeaderCell else {fatalError("Unable to creare explore table view cell")}
//
//            cell.nameLabel.text = profileItems[indexPath.row].fullName
//
//            if let url = URL(string: profileItems[indexPath.row].photo100) {
//                AF.download(url, method: .get).responseData { response in
//                    guard let data = response.value else { return }
//                    let avatar = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        cell.avatar.image = avatar
//                        cell.avatar.layer.cornerRadius = cell.avatar.frame.size.width / 2
//                        cell.avatar.clipsToBounds = true
//                        cell.avatar.contentMode = .scaleAspectFill
//                        cell.avatar.translatesAutoresizingMaskIntoConstraints = false
//                    }
//                }
//            }
//
//            return cell
//
//        case 1:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.profileInfoCell.rawValue, for: indexPath) as? ProfileInfoCell else { fatalError("Unable to creare explore table view cell") }
//
//            cell.cityLabel.text = "Город: New York"
//            cell.bdLabel.text = "День рождения: \(String(profileItems[indexPath.row].bdate))"
//
//            switch profileItems[indexPath.row].sex {
//            case 0:
//                cell.sexLabel.text = "Пол: не указан"
//            case 1:
//                cell.sexLabel.text = "Пол: женский"
//            case 2:
//                cell.sexLabel.text = "Пол: мужской"
//            default:
//                cell.sexLabel.text = "Пол:"
//            }
//
//            return cell
//
//        case 2:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.profileFriendsCell.rawValue, for: indexPath) as? ProfileFriendsCell else { fatalError("Unable to creare explore table view cell") }
//
//            cell.friendsCountLabel.text = "\(friendsCount)"
//
//            return cell
//
//        default:
//            return UITableViewCell()
//        }
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
    
    // MARK: - Table view delegate
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 2:
//            return 135
//        default:
//            return 125
//        }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
