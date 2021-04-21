//
//  AvatarCachesServies.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 21.04.2021.
//

import UIKit
import Alamofire

fileprivate protocol DataReloadable {
    func reloadRow(indexPath: IndexPath)
}

class AvatarCacheService {
    
    private let cachesTimeLife: TimeInterval = 30 * 24 * 60 * 60
    private var avatars = [String: UIImage]()
    private let container: DataReloadable
    
    private static let pathName: String = {
        let pathName = "avatar"
        
        guard let chachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = chachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
        return pathName
    }()
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        guard let hash = url.split(separator: "/").last else { return "default" }
        return cachesDirectory.appendingPathComponent(AvatarCacheService.pathName + "/" + hash).path
    }
    
    private func saveAvatarToCache(url: String, avatar: UIImage) {
        guard let fileName = getFilePath(url: url), let data = avatar.pngData() else { return }
        
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func loadAvatarFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil }
            
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cachesTimeLife, let avatar = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.avatars[url] = avatar
        }
        return avatar
    }
    
    private func loadAvatar(indexPath: IndexPath, url: String) {
        AF.request(url).response(queue: DispatchQueue.global()) { [weak self] response in
            guard let data = response.data, let avatar = UIImage(data: data) else { return }
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.avatars[url] = avatar
            }
            
            self.saveAvatarToCache(url: url, avatar: avatar)
            
            DispatchQueue.main.async {
                self.container.reloadRow(indexPath: indexPath)
            }
        }
    }
    
    func getAvatar(indexPath: IndexPath, url: String) -> UIImage? {
        var image: UIImage?
        if let avatar = avatars[url] {
            image = avatar
        } else if let avatar = loadAvatarFromCache(url: url) {
            image = avatar
        } else {
            loadAvatar(indexPath: indexPath, url: url)
        }
        return image
    }
}

extension AvatarCacheService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
