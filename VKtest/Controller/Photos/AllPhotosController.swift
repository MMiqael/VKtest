//
//  AllPhotosController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 19.11.2020.
//

import UIKit
//import RealmSwift
import Alamofire

class AllPhotosController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        
    var allPhotos = [PhotosGetAllItems]() // Results<PhotosGetAllItems>?
    let photosNetworkService = PhotosNetworkService()
    var ownerId = 0
//    var token: NotificationToken?
                    
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        loadData()
//        realmNotification()
        
        DispatchQueue.global().async {
            self.photosNetworkService.getAll(ownerId: self.ownerId) { [weak self] response in
                guard let self = self else { return }
                self.allPhotos = response
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
//    func loadData() {
//        do {
//            let realm = try Realm()
//            let results = realm.objects(PhotosGetAllItems.self)
//            allPhotos = results
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        } catch {
//            print(error)
//        }
//    }
    
//    func realmNotification() {
//        guard let realm = try? Realm() else { return }
//        token = realm.objects(PhotosGetAllItems.self).observe({ [weak self] (change: RealmCollectionChange) in
//            guard let collectionView = self?.collectionView else { return }
//            switch change {
//
//            case .initial(_):
//                collectionView.reloadData()
//            case let .update(_, deletions, insertions, modifications):
//                collectionView.performBatchUpdates({
//                    collectionView.deleteItems(at: deletions.map({ IndexPath(item: $0, section: 0) }))
//                    collectionView.insertItems(at: insertions.map({ IndexPath(item: $0, section: 0)}))
//                    collectionView.reloadItems(at: modifications.map({ IndexPath(item: $0, section: 0)}))
//                }, completion: nil)
//            case .error(let error):
//                print(error)
//            }
//        })
//    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == EnumSegueIdentifiers.photoSegue.rawValue else { return }
        guard let largeSizePhotoVC = segue.destination as? LargeSizePhotoController else { return }
        if let _ = collectionView.indexPathsForSelectedItems {
//            largeSizePhotoVC.ownerId = ownerId
            largeSizePhotoVC.largeSizePhotos = allPhotos
        }
    }
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnumReuseIdentifiers.albumCell.rawValue, for: indexPath) as? AllPhotosCell else {fatalError("Unable to creare explore collection view cell")}
                        
        if let url = URL(string: allPhotos[indexPath.item].url) {
            DispatchQueue.global().async {
                AF.download(url, method: .get).responseData { response in
                    guard let data = response.value else { return }
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        cell.photoImageView.image = image
                    }
                }
            }
        }
        return cell
    }
    
    // Переход на выбранное фото
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        photoControllerDelegate?.indexPath = indexPath
        
        let photo = allPhotos[indexPath.row].id
        
        print(photo)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countCells = 3
        let width = (Int(collectionView.frame.width) - 5) / countCells
        return CGSize(width: width, height: width)
    }
}
