//
//  LargeSizePhotoController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 30.11.2020.
//

import UIKit
//import RealmSwift
import Alamofire

class LargeSizePhotoController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var largeSizePhotos = [PhotosGetAllItems]() // Results<PhotosGetAllItems>?
    let photosNetworkService = PhotosNetworkService()
    var ownerId = 0
//    var delegate: UIImage?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        view.addGestureRecognizer(swipeGestureRecognizer)
        
        // Переход на выбранное фото
        //        collectionView.performBatchUpdates(nil) { (result) in
        ////            guard let index = self.indexPath else {return}
        //            self.collectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        //    }
        
//        networkService.getLargeSizePhotos(/*id: id*/) { [weak self] photo in
//            self?.largeSizePhotos = photo
//            self?.collectionView.reloadData()
//        }
        
//        loadData()
        
        photosNetworkService.getAll(ownerId: ownerId) { [weak self] response in
            self?.largeSizePhotos = response
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc func swipe(sender: UISwipeGestureRecognizer) {
        print("swipe")
    }
    
//    func loadData() {
//        do {
//            let realm = try Realm()
//            let images = realm.objects(PhotosGetAllItems.self)
//            largeSizePhotos = images
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        } catch {
//            print(error)
//        }
//    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return largeSizePhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnumReuseIdentifiers.photoCell.rawValue, for: indexPath) as? LargeSizePhotoCell else {fatalError("Unable to creare explore collection view cell")}
        
        if let url = URL(string: largeSizePhotos[indexPath.item].url) {
            DispatchQueue.global().async {
                print(self.largeSizePhotos[indexPath.item].url)
                AF.download(url, method: .get).responseData { response in
                    guard let data = response.value else { return }
                    let image = UIImage(data: data)
                    //                self.delegate = image
                    DispatchQueue.main.async {
                        cell.photoImageView.image = image
                    }
                }
            }
        }
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        let frameCV = collectionView.frame
//        let widthCell = frameCV.width
//        var heightCell: CGFloat = 0
//
//        func resize(_ widthCell: CGFloat,_ widthImage: CGFloat,_ heightImage: CGFloat) -> CGFloat {
//            let widthDifference = widthImage / widthCell
//            let heightCell = heightImage / widthDifference
//            return heightCell
//        }
//
//        if let imageWidth = delegate?.size.width, let imageHeight = delegate?.size.height {
//            let height = resize(widthCell, imageWidth, imageHeight)
//            heightCell = height
//        }
//
//        return CGSize(width: widthCell, height: heightCell)
        
// __________________________
        
//        let heightCell: CGFloat
//        let widthImage: CGFloat?
//        let heightImage: CGFloat?
//
//        if let image = delegate {
//            widthImage = image.size.width
//            heightImage = image.size.height
//        }
//
//        func resize(_ widthCell: CGFloat, _ widthImage: CGFloat, _ heightImage: CGFloat) -> CGFloat {
//            let widthDifference = widthImage / widthCell
//            let heightCell = heightImage / widthDifference
//            return heightCell
//        }
//
//        if let width = widthImage, let height = heightImage) -> CGFloat {
//            let heightCell = resize(widthCell, width, height)
//            return heightCell
//        }
//
//        return CGSize(width: widthCell, height: heightCell)
//    }
}
