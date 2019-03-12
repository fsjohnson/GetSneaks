//
//  SelectedImagesCollectionViewController.swift
//  Memories
//
//  Created by Felicity Johnson on 2/7/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "imageCell"

class SelectedImagesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var sectionInsets: UIEdgeInsets!
    var spacing: CGFloat!
    var itemSize: CGSize!
    var numberOfRows: CGFloat!
    var numberOfColumns: CGFloat!
    
    var originalImageOrderArray = Slideshow.sharedInstance.images
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config nav bar
        configNavigationBar()
        
        // Register cell classes
        self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Layout cells
        configCellLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func configNavigationBar() {
        self.navigationItem.title = "Finalize Image Order"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextStep))
    }
    
    func nextStep() {
        performSegue(withIdentifier: "viewVideo", sender: self)
    }
    
    func configCellLayout() {
        guard let navHeight = navigationController?.navigationBar.frame.height else { print("Error calc nav height on collectionView"); return }
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height - navHeight
        
        numberOfRows = 4
        numberOfColumns = 3
        spacing = 2
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        let totalWidthDeduction = (spacing + spacing + sectionInsets.right + sectionInsets.left)
        let totalHeightDeduction = (spacing + spacing + sectionInsets.bottom + sectionInsets.top)
        itemSize = CGSize(width: (screenWidth - totalWidthDeduction) / numberOfColumns, height: (screenHeight - totalHeightDeduction) / numberOfRows)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Slideshow.sharedInstance.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        cell.cellImageView.image = Slideshow.sharedInstance.images[indexPath.item]
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    // MARK: - Handle changing order of images
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.collectionView?.performBatchUpdates({
            let itemToMove = Slideshow.sharedInstance.images.remove(at: sourceIndexPath.item)
            Slideshow.sharedInstance.images.insert(itemToMove, at: destinationIndexPath.item)
        }, completion: { completed in
            print("item moved")
        })
    }
}


