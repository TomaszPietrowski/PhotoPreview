//
//  PhotoPreviewConnector.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

typealias NotificationCallback = () -> Void

class PhotoPreviewConnector {
    
    var onDismiss: NotificationCallback?
    
    private let displayData: PhotoPreviewDisplayData
    
    init(displayData: PhotoPreviewDisplayData) {
        self.displayData = displayData
    }
    
    func photoPreviewViewController() -> PhotoPreviewViewController {
        let presenter = PhotoPreviewPresenter(connector: self, displayData: displayData)
        let viewController = PhotoPreviewViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
