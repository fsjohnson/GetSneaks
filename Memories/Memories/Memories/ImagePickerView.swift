//
//  ImagePickerView.swift
//  Memories
//
//  Created by Felicity Johnson on 2/7/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class ImagePickerView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var completedSelection = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("image picker config called")
        self.handleSelectImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imagePicker: UIImagePickerController = {
       return UIImagePickerController()
    }()
    
    private func handleSelectImages() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            Slideshow.sharedInstance.images.append(editedImage)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            Slideshow.sharedInstance.images.append(originalImage)
        }
        NotificationCenter.default.post(name: Notification.Name("finished-image-selection"), object: nil)
    }
}
