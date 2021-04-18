//
//  OldControllers.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 08.01.2021.
//

import UIKit

// MARK: - FriendsListController

//class FriendsListController: UITableViewController {
//
//    let friendsList = [FriendsListStruct(userName: "Mark", userSurname: "Zucerberg" , userAvatar: "Zucerberg 1 Avatar", userPhotos: ["Zucerberg 2", "Zucerberg 3", "Zucerberg 4"]),
//                       FriendsListStruct(userName: "Elon", userSurname: "Musk", userAvatar: "Musk 1 Avatar", userPhotos: ["Musk 2", "Musk 3", "Musk 4"]),
//                       FriendsListStruct(userName: "Steve", userSurname: "Jobs", userAvatar: "Jobs 1 Avatar", userPhotos: ["Jobs 2", "Jobs 3", "Jobs 4"]),
//                       FriendsListStruct(userName: "Bill", userSurname: "Gates", userAvatar: "Gates 1 Avatar", userPhotos: ["Gates 2", "Gates 3", "Gates 4"]),
//                       FriendsListStruct(userName: "Pavel", userSurname: "Durov", userAvatar: "Durov 1 Avatar", userPhotos: ["Durov 2", "Durov 3", "Durov 4"]),
//                       FriendsListStruct(userName: "Steve", userSurname: "Wozniak", userAvatar: "Wozniak 1 Avatar", userPhotos: ["Wozniak 2", "Wozniak 3", "Wozniak 4"]),
//                       FriendsListStruct(userName: "Sergey", userSurname: "Brin", userAvatar: "Brin 1 Avatar", userPhotos: ["Brin 2", "Brin 3", "Brin 4"]),
//                       FriendsListStruct(userName: "Tim", userSurname: "Cook", userAvatar: "Cook 1 Avatar", userPhotos: ["Cook 1 Avatar", "Cook 2", "Cook 3", "Cook 4", "Brin 2", "Brin 3", "Brin 4", "Wozniak 2", "Wozniak 3", "Wozniak 4"])]
//
//    var friendSection = [Section]()
//
//    @IBOutlet weak var searchBar: UISearchBar!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.tableFooterView = UIView()
//        navigationItem.title = "Мои друзья"
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        searchBar.delegate = self
//        //        searchBar.showsCancelButton = true
//
//        sortedFriends(friends: friendsList)
//
//        guard let accessToken = Session.shared.token else { return }
//        guard let userId = Session.shared.userId else { return }
//
//        print("accessToken: \(accessToken)")
//        print("userId: \(userId)")
//
//        let networkService = NetworkService(accessToken: accessToken, userId: userId)
//        networkService.friendsGet()
//    }
//
//
//    func sortedFriends(friends: [FriendsListStruct]) {
//        let friendsDict = Dictionary.init(grouping: friends, by: { $0.userSurname.prefix(1) })
//        friendSection = friendsDict.map {Section(title: String($0.key), items: $0.value)}
//        friendSection.sort { $0.title < $1.title }
//    }
//
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return friendSection.count
//    }
//
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        var letters = [String]()
//
//        for friend in friendsList {
//            let firstLetter = String(friend.userSurname.first!)
//            if !letters.contains(firstLetter) {
//                letters.append(firstLetter)
//                letters.sort { $0 < $1 }
//            }
//        }
//        return letters
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        let headerLabel = UILabel()
//
//        headerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
//        headerLabel.text = friendSection[section].title
//        headerLabel.textColor = tableView.backgroundColor
//        headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
//
//        headerView.addSubview(headerLabel)
//        headerLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
//            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15)
//        ])
//
//        return headerView
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return friendSection[section].items.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.friendsCell.rawValue, for: indexPath) as? FriendsListCell else {fatalError("Unable to creare explore table view cell")}
//
//        cell.nameLabel.text = friendSection[indexPath.section].items[indexPath.row].userFullName
//        cell.nameLabel.adjustsFontSizeToFitWidth = true
//        cell.nameLabel.minimumScaleFactor = 0.5
//        cell.avatarView.avatar.image = UIImage(named: friendSection[indexPath.section].items[indexPath.row].userAvatar)
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//
//    // MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == EnumSegueIdentifiers.albumSegue.rawValue else { return }
//        guard let vc = segue.destination as? AlbumController else { return }
//        if let index = tableView.indexPathForSelectedRow {
//            let friend = friendSection[index.section]
//            vc.albumPhotos = friend.items[index.row].userPhotos
//            vc.title = friend.items[index.row].userFullName
//        }
//    }
//}
//
//
//// MARK: - Extension
//
//extension FriendsListController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            sortedFriends(friends: friendsList)
//        } else {
//            let filteredFriends = friendsList.filter { (friend: FriendsListStruct) -> Bool in
//                friend.userName.lowercased().prefix(searchText.count) == searchText.lowercased() || friend.userSurname.lowercased().prefix(searchText.count) == searchText.lowercased()
//            }
//            sortedFriends(friends: filteredFriends)
//        }
//        tableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        sortedFriends(friends: friendsList)
//        // MARK: Скрыть клавиатуру и выйти из режима поиска
//        tableView.keyboardDismissMode = .onDrag
//        tableView.reloadData()
//    }
//}


//struct FriendsListStruct {
//    var userName: String
//    var userSurname: String
//    var userAvatar: String
//    var userPhotos: [String]
//    var userFullName: String {
//        get {
//            return "\(userName) \(userSurname)"
//        }
//    }
//}

    // MARK: - MyGroupsController

//class MyGroupsController: UITableViewController {
//
//    var myGroupsList = [GroupsListStruct(name: "Swift", image: "Swift"),
//                        GroupsListStruct(name: "Вдудь", image: "Vdud"),
//                        GroupsListStruct(name: "Apple", image: "Apple")]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.tableFooterView = UIView()
//        navigationItem.title = "Мои группы"
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        guard let accessToken = Session.shared.token else { return }
//        guard let userId = Session.shared.userId else { return }
//
//        print("accessToken: \(accessToken)")
//        print("userId: \(userId)")
//
//        let networkService = NetworkService(accessToken: accessToken, userId: userId)
//        networkService.groupsGet()
//    }
//
//    @IBAction func unwindToMyGroupsController(_ unwindSegue: UIStoryboardSegue) {
//        if unwindSegue.identifier == EnumUnwindSegueIdentifiers.addNewGroup.rawValue {
//            guard let sourceViewController = unwindSegue.source as? AllGroupsController else { return }
//            if let indexPath = sourceViewController.tableView.indexPathForSelectedRow {
//                let newGroup = sourceViewController.allGroupsList[indexPath.row]
//                if !myGroupsList.contains(newGroup) {
//                    myGroupsList.append(newGroup)
//                    tableView.reloadData()
//                }
//            }
//        }
//    }
//
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myGroupsList.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.myGroupsCell.rawValue, for: indexPath) as? MyGroupsCell else {fatalError("Unable to creare explore table view cell")}
//
//        cell.nameLabel.text = myGroupsList[indexPath.row].name
//        cell.avatarView.avatar.image = UIImage(named: myGroupsList[indexPath.row].image)
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            myGroupsList.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//}


    // MARK: - AllGroupsController

//class AllGroupsController: UITableViewController {
//
//    var allGroupsList = [GroupsListStruct(name: "Facebook", image: "Facebook"),
//                         GroupsListStruct(name: "Instagram", image: "Instagram"),
//                         GroupsListStruct(name: "Telegram", image: "Telegram")]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.tableFooterView = UIView()
//        navigationItem.title = "Поиск групп"
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        guard let accessToken = Session.shared.token else { return }
//        guard let userId = Session.shared.userId else { return }
//
//        let networkService = NetworkService(accessToken: accessToken, userId: userId)
//        networkService.searchGroupsGet()
//    }
//
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return allGroupsList.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.allGroupsCell.rawValue, for: indexPath) as? AllGroupsCell else {fatalError("Unable to creare explore table view cell")}
//
//        cell.nameLabel.text = allGroupsList[indexPath.row].name
//        cell.avatarView.avatar.image = UIImage(named: allGroupsList[indexPath.row].image)
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}

    // MARK: - AlbumController

//class AlbumController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    var albumPhotos: [String] = []
////    var photoControllerDelegate: PhotoController?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationItem.title = "Альбом"
//
//        guard let accessToken = Session.shared.token else { return }
//        guard let userId = Session.shared.userId else { return }
//
//        print("accessToken: \(accessToken)")
//        print("userId: \(userId)")
//
//        let networkService = NetworkService(accessToken: accessToken, userId: userId)
//        networkService.photosGet()
//    }
//
//
//    // MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == EnumSegueIdentifiers.photoSegue.rawValue else { return }
//        guard let vc = segue.destination as? PhotoController else { return }
//        if let _ = collectionView.indexPathsForSelectedItems{
//            vc.photos = albumPhotos
//        }
//    }
//
//
//    // MARK: - UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return albumPhotos.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnumReuseIdentifiers.albumCell.rawValue, for: indexPath) as? AlbumCell else {fatalError("Unable to creare explore collection view cell")}
//
//        cell.photoImageView.image = UIImage(named: albumPhotos[indexPath.row])
//
//        return cell
//    }
//
//    // Переход на выбранное фото
////    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        photoControllerDelegate?.indexPath = indexPath
////
////    }
//
//    // MARK: - UICollectionViewDelegateFlowLayout
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let countCells = 3
//        let width = (Int(collectionView.frame.width) - 5) / countCells
//        return CGSize(width: width, height: width)
//    }
//}
//

// MARK: - EnterController

//class EnterController: UIViewController {
//
//    let blueCGColor = UIColor.systemBlue.cgColor
//    let greenCGColor = UIColor.green.cgColor
//    let redCGColor = UIColor.red.cgColor
//    let whiteCGColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//    var gradient: CAGradientLayer! {
//        didSet {
//            gradient.startPoint = CGPoint(x: 0.4, y: 0)
//            gradient.endPoint = CGPoint(x: 1, y: 1)
//            let startColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
//            let endColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
//            gradient.colors = [startColor, endColor]
//            gradient.locations = [0, 1]
//        }
//    }
//
//    var shapeLayer: CAShapeLayer! {
//        didSet {
//            shapeLayer.fillColor = nil
//            shapeLayer.lineWidth = 5
//            shapeLayer.strokeEnd = 1
//            shapeLayer.strokeColor = blueCGColor
//        }
//    }
//
//    var overShapeLayer: CAShapeLayer! {
//        didSet {
//            overShapeLayer.fillColor = nil
//            overShapeLayer.lineWidth = 5
//            overShapeLayer.strokeEnd = 0
//            overShapeLayer.strokeColor = redCGColor
//            overShapeLayer.lineCap = .round
//        }
//    }
//
//    @IBOutlet weak var vkLabel: UILabel! {
//        didSet {
//            vkLabel.textColor = whiteCGColor
//            vkLabel.font = UIFont.boldSystemFont(ofSize: 30)
//        }
//    }
//
//    @IBOutlet weak var loginTextField: UITextField! {
//        didSet {
//            loginTextField.font = UIFont.systemFont(ofSize: 16)
//            loginTextField.textColor = whiteCGColor
//            loginTextField.tintColor = whiteCGColor
//            loginTextField.clearButtonMode = .whileEditing
//        }
//    }
//
//    @IBOutlet weak var passwordTextField: UITextField! {
//        didSet {
//            passwordTextField.font = UIFont.systemFont(ofSize: 16)
//            passwordTextField.textColor = whiteCGColor
//            passwordTextField.tintColor = whiteCGColor
//            passwordTextField.clearButtonMode = .whileEditing
//        }
//    }
//
//    @IBOutlet weak var enterButtonOutlet: UIButton! {
//        didSet {
//            enterButtonOutlet.setTitle("Войти", for: .normal)
//            enterButtonOutlet.setTitleColor(whiteCGColor, for: .normal)
//        }
//    }
//
//    override func viewDidLayoutSubviews() {
//        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        gradient = CAGradientLayer()
//        view.layer.insertSublayer(gradient, at: 0)
//
//        shapeLayer = CAShapeLayer()
//        enterButtonOutlet.layer.addSublayer(shapeLayer)
//
//        overShapeLayer = CAShapeLayer()
//        enterButtonOutlet.layer.addSublayer(overShapeLayer)
//
//        config(shapeLayer, with: enterButtonOutlet)
//        config(overShapeLayer, with: enterButtonOutlet)
//
//    }
//
//    @IBAction func enterButtonAction(_ sender: Any) {
//        animation(overShapeLayer)
//    }
//
//    @IBAction func logInWithVK(_ sender: Any) {
//    }
//
//
//    func config(_ shapeLayer: CAShapeLayer, with view: UIView) {
//        shapeLayer.frame = view.bounds
//
//        let viewX = view.bounds.origin.x
//        let viewY = view.bounds.origin.y
//        let viewWidth = view.bounds.size.width
//        let viewHeight = view.bounds.size.height
//
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: viewWidth / 2, y: viewY))
//        path.addLine(to: CGPoint(x: viewWidth, y: viewY))
//        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
//        path.addLine(to: CGPoint(x: viewX, y: viewHeight))
//        path.addLine(to: CGPoint(x: viewX, y: viewY))
//
//        path.close()
//        path.stroke()
//
//        shapeLayer.path = path.cgPath
//    }
//
//    func animation(_ layer: CAShapeLayer) {
//        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
//        animation.toValue = 1
//        animation.duration = 2
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        animation.fillMode = CAMediaTimingFillMode.both
//        animation.isRemovedOnCompletion = false
//
//        animation.delegate = self
//
//        layer.add(animation, forKey: nil)
//    }
//
//    // MARK: Доделать форму для входа
//
//}
//
//extension EnterController: CAAnimationDelegate {
//
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        overShapeLayer.strokeColor = greenCGColor
//        performSegue(withIdentifier: EnumSegueIdentifiers.fromEnter.rawValue, sender: self)
//    }
//}


    // MARK: - NewsFeedController
//class NewsFeedController: UITableViewController {
//
//    let news = [NewsFeedStruct(name: "Pavel Durov", time: "10 минут назад", avatar: "Durov 1 Avatar", message: EnumNewsText.durov.rawValue, picture: "durov"),
//                NewsFeedStruct(name: "Apple", time: "6 часов назад", avatar: "Apple", message: EnumNewsText.apple.rawValue, picture: "iPhone 12"),
//                NewsFeedStruct(name: "вДудь", time: "сегодня в 18:30", avatar: "Vdud", message: EnumNewsText.vDud.rawValue, picture: "vDud-1")]
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.tableFooterView = UIView()
//        navigationItem.title = "Новости"
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return  news.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnumReuseIdentifiers.newsFeedCell.rawValue, for: indexPath) as? NewsFeedCell else {fatalError("Unable to creare explore table view cell")}
//
//        cell.avatarView.avatar.image = UIImage(named: news[indexPath.row].avatar)
//        cell.nameLabel.text = news[indexPath.row].name
//        cell.timeLabel.text = news[indexPath.row].time
//        cell.messageLabel.text = news[indexPath.row].message
//        cell.pictureImageView.image = UIImage(named: news[indexPath.row].picture)
//        cell.backgroundColor = .systemBackground
//        cell.separatorView.backgroundColor = .systemGray5
//
//        return cell
//    }
//
//    // MARK: - Table view delegate
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
//
//// MARK: - Extension
//
////extension NewsFeedController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return 1
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnumReuseIdentifiers.newsImageCell.rawValue, for: indexPath) as! NewsImageCell
////
////        cell.pictureImageView.image = UIImage(named: news[indexPath.row].picture)
////
////        return cell
////    }
////
////
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////
////        let frameCV = collectionView.frame
////        let widthCell = frameCV.width
////
////        let image = UIImage(named: news[indexPath.row].picture)
////        let widthImage = image!.size.width
////        let heightImage = image!.size.height
////
////        func resize(_ widthCell: CGFloat, _ widthImage: CGFloat, _ heightImage: CGFloat) -> CGFloat {
////            let widthDifference = widthImage / widthCell
////            let heightCell = heightImage / widthDifference
////            return heightCell
////        }
////
////        let heightCell = resize(widthCell, widthImage, heightImage)
////
////        return CGSize(width: widthCell, height: heightCell)
////    }
////}
