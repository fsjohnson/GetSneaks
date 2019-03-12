//
//  VideoView.swift
//  Memories
//
//  Created by Felicity Johnson on 2/7/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import AVKit

class VideoView: UIView {
    
    var videoWriter: AVAssetWriter?
    let outputSize = CGSize(width: 1920, height: 1080)
    
    weak var delegate: PopulateSlideshow? {
        didSet {
            guard let images = self.delegate?.getImages() else { print("Error retrieving images via delegate"); return }
            imagesSelected = images
            VideoConverter.convertToVideo(from: imagesSelected, progress: { (progress) in
            }) { (success) in
                OperationQueue.main.addOperation {
                    self.configView(url: success.absoluteString)
                }
            }
        }
    }
    
    lazy var imagesSelected = [UIImage]()
    lazy var player = AVPlayer()
    lazy var controller = AVPlayerViewController()
    lazy var invisibleButton = UIButton()
    lazy var isPlaying = Bool()
    
    private func configView(url: String) {
        //MARK: Movie config
        guard let url: URL = URL(string: url) else { return }
        player = AVPlayer(url: url)
        controller.player = player
        controller.view.frame = self.bounds
        self.addSubview(controller.view)
        self.player.play()
        self.isPlaying = true
    }
}
