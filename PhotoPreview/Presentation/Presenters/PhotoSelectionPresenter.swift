//
//  PhotoSelectionPresenter.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 27.09.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

protocol PhotoSelectionPresenting {
    var numberOfPhotos: Int { get }
    func viewReady()
    func configureCell(_ cell: PhotoSelectionCell, at index: Int)
    func didSelecCell(at index: Int)
}

final class PhotoSelectionPresenter: PhotoSelectionPresenting {
    
    weak var view: PhotoSelectionView!
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    private let connector: PhotoSelectionConnecting
    private let factory: PhotoUseCaseProducing
    private let imageLoader: ImageLoader
    private var photos: [PhotoData] = []
    
    init(connector: PhotoSelectionConnecting, factory: PhotoUseCaseProducing, imageLoader: ImageLoader = KingfisherImageLoader()) {
        self.connector = connector
        self.factory = factory
        self.imageLoader = imageLoader //TODO: Pass image loader and remove default value
    }
    
    func viewReady() {
        photos = factory.getPhotosUseCase(count: 24).execute()
    }
    
    func configureCell(_ cell: PhotoSelectionCell, at index: Int) {
        cell.displayImage(photos[index].thumbnailURL, imageLoader: imageLoader)
    }
    
    func didSelecCell(at index: Int) {
        //TODO: Show photo preview
    }
}
