//
//  PostsView.swift
//  BFFSampleCode
//
//  Created by Felicity Johnson on 12/13/16.
//  Copyright © 2016 FJ. All rights reserved.
//

import UIKit

protocol BookPostDelegate: class {
    func canDisplayImage(sender: PostsView) -> Bool
}

class PostsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentLabel: UITextView!
    @IBOutlet weak var bookImage: UIImageView!
    
    weak var delegate: BookPostDelegate!
    weak var bookPost: BookPosted! {
        didSet {
            titleLabel.text = bookPost.title
            updateViewToReflectUsername()
            commentLabel.text = "\"\(bookPost.comment)\""
            updateViewToReflectBookImage()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Content view config
        Bundle.main.loadNibNamed("PostsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.constrainEdges(to: self)
        self.contentView.layer.borderColor = UIColor.themeWhite.cgColor
        self.contentView.layer.borderWidth = 4.0
        
        // Username config
        usernameLabel.font = UIFont.themeSmallBold
        usernameLabel.textColor = UIColor.themeDarkGrey
        
        // Book title config
        titleLabel.font = UIFont.themeSmallBold
        titleLabel.textColor = UIColor.themeOrange
        
        // Comment label config
        commentLabel.font = UIFont.themeSmallLight
        commentLabel.textColor = UIColor.themeDarkGrey
    }
}

//Mark: Cell content extension

extension PostsView {
    
    fileprivate func updateViewToReflectBookImage() {
        if bookPost.imageLink == "" {
            bookImage.image = UIImage(named: "BFFLogo")
        } else {
            OperationQueue.main.addOperation {
                if self.delegate.canDisplayImage(sender: self) {
                    self.bookImage.loadImageUsingCacheWithURLString(urlString: self.bookPost.imageLink)
                }
            }
        }
    }
    
    fileprivate func updateViewToReflectUsername() {
        FirebaseMethods.retrieveSpecificUser(with: bookPost.userUniqueKey, completion: { (user) in
            guard let user = user else { return }
            self.usernameLabel.text = "- \(user.username)"
        })
    }
}

//Mark: PostsView UIView extension

extension UIView {
    
    func constrainEdges(to view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}



