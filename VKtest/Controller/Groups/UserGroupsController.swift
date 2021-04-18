//
//  UserGroupsController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 19.11.2020.
//

import UIKit
import RealmSwift
import Alamofire

class UserGroupsController: UITableViewController {
    
    private var userGroups = [GroupsGet]() // Results<GroupsGet>?
//    private var token: NotificationToken?
    
    let groupsNetworkService = GroupsNetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        navigationItem.title = "Мои группы"
        navigationController?.navigationBar.prefersLargeTitles = true
                
//        loadData()
//        realmNotifications()
        
        groupsNetworkService.get { [weak self] results in
            self?.userGroups = results.items
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    deinit {
        
    }
    
//    func loadData() {
//        do {
//            let realm = try Realm()
//            let results = realm.objects(GroupsGet.self)
//            userGroups = results
//            tableView.reloadData()
//        } catch {
//            print(error)
//        }
//    }
    
//    func realmNotifications() {
//        guard let realm = try? Realm() else { return }
//        token = realm.objects(GroupsGet.self).observe({ [weak self] (changes: RealmCollectionChange) in
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
    
    @IBAction func unwindToMyGroupsController(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == EnumUnwindSegueIdentifiers.addNewGroup.rawValue {
            guard let sourceViewController = unwindSegue.source as? SearchGroupsController else { return }
            if let indexPath = sourceViewController.tableView.indexPathForSelectedRow {
                let newGroup = sourceViewController.searchGroups[indexPath.row]
                
                if newGroup.isMember == 0 {
//                    do {
//                        let realm = try Realm()
//                        realm.beginWrite()
//                        realm.add(newGroup, update: .modified)
//                        try realm.commitWrite()
//                    } catch {
//                        print(error)
//                    }
                    groupsNetworkService.join(groupId: newGroup.id)
                    tableView.reloadData()
                } else {
                    print("Add group error")
                }
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.userGroupsCell.rawValue, for: indexPath) as? GroupsCell else {fatalError("Unable to creare explore table view cell")}
                
        cell.nameLabel.text = userGroups[indexPath.row].name
        
        if let url = URL(string: userGroups[indexPath.row].photo50) {
            DispatchQueue.global().async {
                AF.download(url, method: .get).responseData { response in
                    guard let data = response.value else { return }
                    DispatchQueue.main.async {
                        let avatar = UIImage(data: data)
                        cell.avatar.image = avatar
                        cell.avatar.layer.cornerRadius = cell.avatar.frame.size.width / 2
                        cell.avatar.clipsToBounds = true
                        cell.avatar.contentMode = .scaleAspectFill
                        cell.avatar.translatesAutoresizingMaskIntoConstraints = false
                    }
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let group = userGroups[indexPath.row]
        if editingStyle == .delete {
            groupsNetworkService.leave(groupId: group.id)
            tableView.reloadData()
//            do {
//                let realm = try Realm()
//                realm.beginWrite()
//                realm.delete(group)
//                try realm.commitWrite()
//            } catch {
//                print(error)
//            }
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
