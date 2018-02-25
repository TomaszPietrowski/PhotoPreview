//
//  UIImageView+setImage.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(using imageURL: URL, imageLoader: ImageLoader, animated: Bool = true, placeholder: UIImage? = nil, completion: ((CGSize) -> Void)? = nil) {
        imageLoader.setImage(
            with: imageURL,
            imageView: self,
            animated: animated,
            placeholder: placeholder,
            completion: completion
        )
    }
}
