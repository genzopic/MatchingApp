//
//  User.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/19.
//

import Foundation
import FirebaseFirestore

class User {
    
    var email: String
    var name: String
    var age: Int
    var regidence: String
    var hobby: String
    var introduction: String
    var profileImageUrl: String
    var creatAt: Timestamp
    
    init(dic: [String:Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.age = dic["age"] as? Int ?? 0
        self.regidence = dic["regidence"] as? String ?? ""
        self.hobby = dic["hobby"] as? String ?? ""
        self.introduction = dic["introduction"] as? String ?? ""
        self.profileImageUrl = dic["profileImageUrl"] as? String ?? ""
        self.creatAt = dic["creatAt"] as? Timestamp ?? Timestamp()
    }
    
}
