//
//  SearchGroupsController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 19.11.2020.
//

import UIKit
import Alamofire

// MARK: При быстром наборе текста приложение падает

class SearchGroupsController: UITableViewController {
    
    var searchGroups = [GroupsGet]()
//    private let groupsNetworkService = GroupsNetworkService()
    private let groupNSAdapter = GroupsNSAdapter()
    lazy var avatarCacheService = AvatarCacheService(container: tableView)
    
//    private var timer: Timer?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        navigationItem.title = "Поиск групп"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.searchGroupsCell.rawValue, for: indexPath) as? SearchGroupsCell else {fatalError("Unable to creare explore table view cell")}
        
        cell.nameLabel.text = searchGroups[indexPath.row].name
        
        let url = searchGroups[indexPath.row].photo50
        cell.avatar.image = avatarCacheService.getAvatar(indexPath: indexPath, url: url)
        
    return cell
}
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Extesion

extension SearchGroupsController: UISearchBarDelegate {
    // MARK: Доработать
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        if !searchText.isEmpty {
        //            timer?.invalidate()
        //            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
        //                self.networkService.getAllGroups(by: searchText) { [weak self] group in
        //                    self?.allGroupsList = group
        //                }
        //            })
        //            tableView.reloadData()
        //            print(searchText)
        //        } else if searchText == "" {
        //            allGroupsList.removeAll()
        //            tableView.reloadData()
        //        }
        
        if !searchText.isEmpty {
//            groupsNetworkService.search(by: searchText) { [weak self] group in
//                self?.searchGroups = group.items
//                DispatchQueue.main.async() {
//                    self?.tableView.reloadData()
//                }
//            }
            
            groupNSAdapter.search(by: searchText) { [weak self] group in
                guard let self = self else { return }
                self.searchGroups = group.items
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
            }
        } else if searchText == "" {
            searchGroups.removeAll()
            tableView.reloadData()
        }
    }
}
