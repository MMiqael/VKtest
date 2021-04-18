//
//  Enums.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 23.11.2020.
//

import Foundation

enum EnumReuseIdentifiers: String {
    case newsFeedCell = "newsFeedCell"
    case newsImageCell = "newsImageCell"
    case friendsCell = "friendsCell"
    case albumCell = "albumCell"
    case photoCell = "photoCell"
    case userGroupsCell = "userGroupsCell"
    case searchGroupsCell = "searchGroupsCell"
    case profileHeaderCell = "profileHeaderCell"
    case profileInfoCell = "profileInfoCell"
    case profileFriendsCell = "profileFriendsCell"
    case profileWallCell = "profileWallCell"
    case profileFriendsCollectionCell = "profileFriendsCollectionCell"
    case fromProfileToFriends = "fromProfileToFriends"
}

enum EnumSegueIdentifiers: String {
    case albumSegue = "albumSegue"
    case photoSegue = "photoSegue"
    case fromEnter = "fromEnter"
    case toEnter = "toEnter"
    case toProfile = "toProfile"
}

enum EnumUnwindSegueIdentifiers: String {
    case addNewGroup = "addNewGroup"
}

enum EnumDefaultValues: String {
    case camera50 = "https://vk.com/images/camera_50.png"
    case camera100 = "https://vk.com/images/camera_100.png"
}


enum EnumNewsText: String {
    case durov = "В мае я предсказал, что уязвимости в WhatsApp будут выявляться, а серьезные проблемы в области безопасности будут следовать одна за другой, как было раньше"
    case vDud = "Смотрите новый выпуск вДудя на нашем youtube-канале!"
    case apple = "Новый дизайн, поддержка 5G, новое покрытие Ceramic Shield, LiDAR, MagSafe - и многое другое в новом iPhone 12 Pro!"
}


