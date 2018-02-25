//
//  PhotoPreviewCell.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

class PhotoPreviewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    private var imageViewTopConstraint: NSLayoutConstraint!
    private var imageViewLeftConstraint: NSLayoutConstraint!
    private var imageViewRightConstraint: NSLayoutConstraint!
    private var imageViewBottomConstraint: NSLayoutConstraint!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Colors.PhotoPreview.background
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func displayImage(_ image: PhotoData, imageLoader: ImageLoader) {
        imageView.setImage(
            using: image.imageURL,
            imageLoader: imageLoader,
            animated: false,
            placeholder: UIImage.fromColor(color: .clear, size: contentView.bounds.size),
            completion: { [weak self] imageSize in
                self?.updateZoomScale(for: imageSize)
                self?.updateImageViewConstraints()
            }
        )
    }
    
    private func setupScrollView() {
        contentView.addSubview(scrollView, with: [
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        scrollView.delegate = self
    }
    
    private func setupImageView() {
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        imageViewLeftConstraint = imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        imageViewRightConstraint = imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        
        scrollView.addSubview(imageView, with: [
            imageViewTopConstraint,
            imageViewLeftConstraint,
            imageViewRightConstraint,
            imageViewBottomConstraint
        ])
    }
    
    private func updateZoomScale(for imageSize: CGSize) {
        let widthScale = contentView.bounds.width / imageSize.width
        let heightScale = contentView.bounds.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = minScale * 5.0
        scrollView.zoomScale = minScale
    }
    
    private func updateImageViewConstraints() {
        let contentSize = contentView.bounds.size
        let yOffset = max(0, (contentSize.height - imageView.frame.height) / 2)
        let xOffset = max(0, (contentSize.width - imageView.frame.width) / 2)
        
        imageViewTopConstraint.constant = yOffset
        imageViewLeftConstraint.constant = xOffset
        imageViewRightConstraint.constant = -xOffset
        imageViewBottomConstraint.constant = -yOffset
        
        contentView.layoutIfNeeded()
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateImageViewConstraints()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
