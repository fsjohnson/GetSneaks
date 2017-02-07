//
//  Extensions.swift
//  BFFSampleCode
//
//  Created by Felicity Johnson on 12/14/16.
//  Copyright © 2016 FJ. All rights reserved.
//

import Foundation
import UIKit


//Mark: Cache image extension

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithURLString(urlString: String) {
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        guard let url = URL(string: urlString) else { print("error retrieving image url"); return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as! String)
            }
            guard let data = data else { return }
            OperationQueue.main.addOperation {
                if let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}

// Mark: - Feed presentation method

extension FeedTableViewController: BookPostDelegate {
    
    func canDisplayImage(sender: PostsView) -> Bool {
        guard let viewableIndexPaths = tableView.indexPathsForVisibleRows else { return false }
        var books: Set<BookPosted> = []
        for indexPath in viewableIndexPaths {
            let currentBook = postsArray[indexPath.row]
            books.insert(currentBook)
        }
        return books.contains(sender.bookPost)
    }
}


// Mark: - Custom color

extension UIColor {
    public static let themeOrange = UIColor(red: 240 / 255, green: 125 / 255, blue: 50 / 255, alpha: 1)
    public static let themeLightGrey = UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1)
    public static let themeDarkGrey = UIColor(red: 36 / 255, green: 36 / 255, blue: 36 / 255, alpha: 1)
    public static let themeWhite = UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1)
    public static let themeBlack = UIColor(red: 13 / 255, green: 13 / 255, blue: 13 / 255, alpha: 1)
    public static let themeDarkBlue = UIColor(red: 1 / 255, green: 13 / 255, blue: 38 / 255, alpha: 1)
    public static let themeLightBlue = UIColor(red: 143 / 255, green: 159 / 255, blue: 191 / 255, alpha: 1)
}

// Mark: - Custom font

extension UIFont {
    
    // Tiny Fonts
    public static let themeTinyThin = UIFont(name: "HelveticaNeue-Thin", size: 11)
    public static let themeTinyLight = UIFont(name: "HelveticaNeue-Light", size: 11)
    public static let themeTinyRegular = UIFont(name: "HelveticaNeue", size: 11)
    public static let themeTinyBold = UIFont(name: "HelveticaNeue-Bold", size: 11)
    
    // Small Fonts
    public static let themeSmallThin = UIFont(name: "HelveticaNeue-Thin", size: 14)
    public static let themeSmallLight = UIFont(name: "HelveticaNeue-Light", size: 14)
    public static let themeSmallRegular = UIFont(name: "HelveticaNeue", size: 14)
    public static let themeSmallBold = UIFont(name: "HelveticaNeue-Bold", size: 14)
    
    // Medium Fonts
    public static let themeMediumThin = UIFont(name: "HelveticaNeue-Thin", size: 24)
    public static let themeMediumLight = UIFont(name: "HelveticaNeue-Light", size: 24)
    public static let themeMediumRegular = UIFont(name: "HelveticaNeue", size: 24)
    public static let themeMediumBold = UIFont(name: "HelveticaNeue-Bold", size: 24)
    
    // Large Fonts
    public static let themeLargeThin = UIFont(name: "HelveticaNeue-Thin", size: 32)
    public static let themeLargeLight = UIFont(name: "HelveticaNeue-Light", size: 32)
    public static let themeLargeRegular = UIFont(name: "HelveticaNeue", size: 32)
    public static let themeLargeBold = UIFont(name: "HelveticaNeue-Bold", size: 32)
    
    // Oversize Fonts
    public static let themeOversizeThin = UIFont(name: "HelveticaNeue-Thin", size: 58)
    public static let themeOversizeLight = UIFont(name: "HelveticaNeue-Light", size: 58)
    public static let themeOversizeRegular = UIFont(name: "HelveticaNeue", size: 58)
    public static let themeOversizeBold = UIFont(name: "HelveticaNeue-Bold", size: 58)
}

// Mark: - Book posted hashable extension

extension BookPosted: Hashable {
    
    var hashValue: Int {
        return bookUniqueID.hashValue
    }
    
    static func ==(lhs: BookPosted, rhs: BookPosted) -> Bool {
        return (lhs.bookUniqueID) == (rhs.bookUniqueID)
    }
}


