//
//  Session.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 17.12.2020.
//

import Foundation
import UIKit

class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var userId: String?
    var token: String?
}
