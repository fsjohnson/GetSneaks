//
//  ViewController.swift
//  Memories
//
//  Created by Felicity Johnson on 2/7/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(dismissImagePickerViewAndDisplayImageCollectionView), name: Notification.Name("finished-image-selection"), object: nil)
    }
    
    lazy var imagePickerView: ImagePickerView = {
        return ImagePickerView()
    }()
    
    lazy var imageCollectionView: UICollectionView = {
        return UICollectionView()
    }()
    
    // MARK: - Actions
    func configNavigationBar() {
        self.navigationItem.title = "Welcome"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select memories", style: .plain, target: self, action: #selector(selectImagesButtonPressed))
    }
    
    func selectImagesButtonPressed() {
        self.view.addSubview(imagePickerView)
        imagePickerView.translatesAutoresizingMaskIntoConstraints = false
        guard let navBottomAnchor = self.navigationController?.navigationBar.bottomAnchor else { print("Error retrieving nav bottom anchor in imagePickerView config");return }
        imagePickerView.topAnchor.constraint(equalTo: navBottomAnchor, constant: 0).isActive = true
        imagePickerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        imagePickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        present(imagePickerView.imagePicker, animated: true, completion: nil)
    }
    
    func dismissImagePickerViewAndDisplayImageCollectionView() {
        print("notification received")
        imagePickerView.imagePicker.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "displayMemories", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayMemories" {
            _ = segue.destination as! SelectedImagesCollectionViewController
        }
    }
}

