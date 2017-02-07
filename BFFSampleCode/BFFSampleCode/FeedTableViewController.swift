//
//  FeedTableViewController.swift
//  BFFSampleCode
//
//  Created by Felicity Johnson on 12/14/16.
//  Copyright © 2016 FJ. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var postsArray = [BookPosted]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        FirebaseMethods.downloadUsersBookPostsArray { (postsArray) in
            guard let posts = postsArray else { print("error downloading posts"); return }
            self.postsArray = posts
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Config
    
    func config() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.themeOrange
        self.tabBarController?.tabBar.barTintColor = UIColor.themeDarkBlue
        
        let navBarAttributesDictionary = [ NSForegroundColorAttributeName: UIColor.themeDarkBlue,NSFontAttributeName: UIFont.themeMediumThin]
        navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        
        FirebaseMethods.downloadUsersBookPostsArray { (postsArray) in
            guard let posts = postsArray else { print("error downloading posts"); return }
            self.postsArray = posts
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksPosted", for: indexPath) as! FriendsBooksPostedTableViewCell
        if cell.postView.delegate == nil { cell.postView.delegate = self }
        cell.postView.bookPost = postsArray[indexPath.row]
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "getBookDetails", sender: self)
    }
    
    // MARK: - Conforming to protocol
    
    func canDisplayImage(sender: BookPosted) -> Bool {
        let viewableCells = tableView.visibleCells as! [FriendsBooksPostedTableViewCell]
        for cell in viewableCells {
            if cell.bookID == sender.bookUniqueID { return true }
        }
        return false
    }
}



