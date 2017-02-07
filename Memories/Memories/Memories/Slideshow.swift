//
//  Slideshow.swift
//  Memories
//
//  Created by Felicity Johnson on 2/7/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

class Slideshow {
    static let sharedInstance = Slideshow()
    private init() {}
    
    var images = [UIImage]()
    var datePosted = Date()
}
