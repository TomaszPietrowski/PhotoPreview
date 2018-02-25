//
//  PhotoPreviewPresenter.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import Foundation

class PhotoPreviewPresenter {
    
    weak var view: PhotoPreviewView?
    
    var numberOfPhotos: Int {
        return displayData.photos.count
    }
    
    private let connector: PhotoPreviewConnector
    private let displayData: PhotoPreviewDisplayData
    private let imageLoader: ImageLoader
    private let imagePrefetcher: ImagesPrefetcher
    
    init(connector: PhotoPreviewConnector, displayData: PhotoPreviewDisplayData, imageLoader: ImageLoader = KingfisherImageLoader(), imagePrefetcher: ImagesPrefetcher = KingfisherImagePrefetcher()) {
        self.connector = connector
        self.displayData = displayData
        self.imageLoader = imageLoader
        self.imagePrefetcher = imagePrefetcher
    }
    
    func viewDidLayoutSubviews() {
        view?.scrollToPhoto(at: displayData.selectedPhotoIndex)
    }
    
    func configureCell(_ cell: PhotoPreviewCell, at index: Int) {
        cell.displayImage(displayData.photos[index], imageLoader: imageLoader)
    }
    
    func prefetchItems(at indexPaths: [IndexPath]) {
        let urls = indexPaths.map { displayData.photos[$0.row].imageURL }
        imagePrefetcher.prefetch(urls: urls)
    }
}
