//
//  PhotoPreviewPresenter.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

class PhotoPreviewPresenter {
    
    weak var view: PhotoPreviewView?
    
    var numberOfPhotos: Int {
        return displayData.photos.count
    }
    
    private let connector: PhotoPreviewConnector
    private let displayData: PhotoPreviewDisplayData
    private let imageLoader: ImageLoader
    
    init(connector: PhotoPreviewConnector, displayData: PhotoPreviewDisplayData, imageLoader: ImageLoader = KingfisherImageLoader()) {
        self.connector = connector
        self.displayData = displayData
        self.imageLoader = imageLoader
    }
    
    func viewDidLayoutSubviews() {
        view?.scrollToPhoto(at: displayData.selectedPhotoIndex)
    }
    
    func configureCell(_ cell: PhotoPreviewCell, at index: Int) {
        cell.displayImage(displayData.photos[index], imageLoader: imageLoader)
    }
}
