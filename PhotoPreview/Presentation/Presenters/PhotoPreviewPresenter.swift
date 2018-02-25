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
    
    init(connector: PhotoPreviewConnector, displayData: PhotoPreviewDisplayData) {
        self.connector = connector
        self.displayData = displayData
    }
}
