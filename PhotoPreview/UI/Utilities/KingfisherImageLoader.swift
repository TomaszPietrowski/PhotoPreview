//
//  KingfisherImageLoader.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import Foundation
import Kingfisher

protocol ImageLoader {
    func setImage(with url: URL?, imageView: UIImageView, animated: Bool, placeholder: UIImage?, completion: ((CGSize) -> Void)?)
}

class KingfisherImageLoader: ImageLoader {
    
    func setImage(with url: URL?, imageView: UIImageView, animated: Bool, placeholder: UIImage?, completion: ((CGSize) -> Void)?) {
        setupActivityIndicator(in: imageView)
        
        imageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: animated ? [.transition(.fade(0.5))] : nil
        ) { (image, _, _, _) in
            guard let image = image else {
                return
            }
            completion?(image.size)
        }
    }
    
    private func setupActivityIndicator(in imageView: UIImageView) {
        imageView.kf.indicatorType = .activity
        (imageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
    }
}
