//
//  User.swift
//  BFFSampleCode
//
//  Created by Felicity Johnson on 12/14/16.
//  Copyright © 2016 FJ. All rights reserved.
//

import Foundation

class User {

    var name: String
    var uniqueKey: String
    var email: String
    var username: String
    var profileImageURL = "No image link"
    
    
    init(name: String, email: String, uniqueKey: String, username: String, profileImageURL: String) {
        self.name = name
        self.email = email
        self.uniqueKey = uniqueKey
        self.username = username
        self.profileImageURL = profileImageURL
    }
}
