//
//  User.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/19.
//

import Foundation
import FirebaseFirestore

class User {
    
    var name: String
    var email: String
    var creatAt: Timestamp
    
    init(dic: [String:Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.creatAt = dic["creatAt"] as? Timestamp ?? Timestamp()
    }
    
}
