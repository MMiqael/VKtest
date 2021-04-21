//
//  FriendsController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 19.11.2020.
//

import UIKit
//import RealmSwift
import Alamofire

class FriendsController: UITableViewController {
    
    private var friends = [FriendsGetItems]() //Results<FriendsGetItems>?
    private var friendsCount: Int?
    private var sortedFriends = [FriendsGetItems]()
//    private var token: NotificationToken?
//    private let friendsNetworkService = FriendsNetworkService()
    private let proxyFriendsNetworkService = ProxyFriendsNetworkService(networkService: FriendsNetworkService())
    
//    private var news: [PostNews] = []
    
    private var isSearching = false
    lazy var avatarCacheService = AvatarCacheService(container: tableView)
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationItem.title = "Мои друзья"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchBar.delegate = self
        
//        let appDelegate = AppDelegate()
//
//        if appDelegate.firstLaunch == false {
//            loadData()
//        }
                
        
//        realmNotifications()
        
        DispatchQueue.global().async {
            self.proxyFriendsNetworkService.get { [weak self] response in
                guard let self = self else { return }
                self.friends = response.items
                self.friendsCount = response.count
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
//    func realmNotifications() {
//        guard let realm = try? Realm() else { return }
//        token = realm.objects(FriendsGetItems.self).observe({ [weak self] (changes: RealmCollectionChange) in
//            guard let tableView = self?.tableView else { return }
//            switch changes {
//            case .initial(_):
//                tableView.reloadData()
//            case let .update(_, deletions, insertions, modifications):
//                tableView.beginUpdates()
//
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
//                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
//                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
//
//                tableView.endUpdates()
//            case .error(let error):
//                print(error)
//            }
//        })
//    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return sortedFriends.count
        } else {
            return friends.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.friendsCell.rawValue, for: indexPath) as? FriendsCell else {fatalError("Unable to creare explore table view cell")}
                
        if isSearching {
            cell.nameLabel.text = sortedFriends[indexPath.row].fullName
            
            let url = sortedFriends[indexPath.row].photo50
            cell.avatar.image = avatarCacheService.getAvatar(indexPath: indexPath, url: url)
            
        } else {
            cell.nameLabel.text = friends[indexPath.row].fullName

            let url = friends[indexPath.row].photo50
            cell.avatar.image = avatarCacheService.getAvatar(indexPath: indexPath, url: url)
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == EnumSegueIdentifiers.albumSegue.rawValue else { return }
        guard let allPhotosVC = segue.destination as? AllPhotosController else { return }
        if let index = tableView.indexPathForSelectedRow {
            allPhotosVC.ownerId = getItemForIndex(index)
            allPhotosVC.title = getTitleForIndex(index)
        }
    }
    
    func getItemForIndex(_ index: IndexPath) -> Int {
        if isSearching {
            return self.sortedFriends[index.row].id
        } else {
            return self.friends[index.row].id
        }
    }
    
    func getTitleForIndex(_ index: IndexPath) -> String {
        if isSearching {
            return self.sortedFriends[index.row].fullName
        } else {
            return self.friends[index.row].fullName
        }
    }
}

    // MARK: - Extension

extension FriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortedFriends = friends.filter({ $0.firstName.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.lastName.lowercased().prefix(searchText.count) == searchText.lowercased() }) 
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }
}
