//
//  PostsFirebase.swift
//  BFFSampleCode
//
//  Created by Felicity Johnson on 12/13/16.
//  Copyright © 2016 FJ. All rights reserved.
//

import Foundation
import Firebase

class FirebaseMethods {
    
    //MARK: - Retrieve user
    
    static func retrieveSpecificUser(with uniqueID: String, completion: @escaping (User?)-> Void) {
        
        let userRef = FIRDatabase.database().reference().child("users").child("cEKPxXYTaWN3cH4AZYkQ4KlkDXf2")
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let userInfoRaw = snapshot.value as? [String:Any]
            guard
                let userInfo = userInfoRaw,
                let name = userInfo["name"] as?  String,
                let username = userInfo["username"] as? String,
                let email = userInfo["email"] as? String,
                let uniqueKey = userInfo["uniqueKey"] as? String,
                let profileImageURL = userInfo["profilePicURL"] as? String
                else { print("\n\n\n\n\n\(userInfoRaw)\n\n\n\n"); return }
            let user = User(name: name, email: email, uniqueKey: uniqueKey, username: username, profileImageURL: profileImageURL)
            completion(user)
        })
    }
    
    //MARK: - Retrieve current user's posts
    
    static func downloadUsersBookPostsArray(with completion: @escaping ([BookPosted]?) -> Void) {
        
        let postRef = FIRDatabase.database().reference().child("posts").child("visible")
        var postsArray = [BookPosted]()
        
        postRef.observeSingleEvent(of: .value, with: { (snapshot) in
            DispatchQueue.main.async {
                guard let snapshotValue = snapshot.value as? [String: Any] else { print("download all posts error"); completion(nil); return }
                for snap in snapshotValue {
                    guard
                        let postInfo = snap.value as? [String: Any],
                        let comment = postInfo["comment"] as? String,
                        let imageLink = postInfo["imageLink"] as? String,
                        let rating = postInfo["rating"] as? String,
                        let userUniqueID = postInfo["userUniqueID"] as? String,
                        let timestampString = postInfo["timestamp"] as? String,
                        let timestamp = Double(timestampString),
                        let bookUniqueID = postInfo["bookUniqueKey"] as? String,
                        let title = postInfo["title"] as? String,
                        let reviewID = postInfo["reviewID"] as? String
                        else {print("error downloading postInfo"); return}
                    
                    if userUniqueID == "cEKPxXYTaWN3cH4AZYkQ4KlkDXf2" {
                        let post = BookPosted(bookUniqueID: bookUniqueID, rating: rating, comment: comment, imageLink: imageLink, timestamp: timestamp, userUniqueKey: userUniqueID, reviewID: reviewID, title: title)
                        postsArray.append(post)
                    }
                }
                postsArray.sort(by: { (first, second) -> Bool in
                    return first.timestamp > second.timestamp
                })
                completion(postsArray)
            }
        })
    }
}
