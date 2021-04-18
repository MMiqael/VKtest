//
//  ProfileController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 28.01.2021.
//

import UIKit
import RealmSwift
import Firebase

class OldProfileController: UIViewController {
    
//    private var profileInfo: Results<Profile>?
//    private let networkService = NetworkService()
    
    @IBOutlet weak var avatarView: AvatarModel!
    @IBOutlet weak var name: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        networkService.getUsers(userIds: userIds) { [weak self] user in
//            self?.profileInfo = user
//            self?.tab
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
    
//    func config() {
//
//        name = profileInfo.fr
//        avatarView.avatar.image = UIImage(named: "durov 1 Avatar")
//
//    }
    
    
//    func loadData() {
//        do {
//            let realm = try Realm()
//            realm.beginWrite()
//            let results = realm.objects(ProfileInfo.self)
//            profileInfo = results
//            try realm.commitWrite()
//            view.reloadInputViews()
//        } catch {
//            print(error)
//        }
//    }
    
}
