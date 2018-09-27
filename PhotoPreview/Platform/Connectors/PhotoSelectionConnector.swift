//
//  PhotoSelectionConnector.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 27.09.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

protocol PhotoSelectionConnecting { }

final class PhotoSelectionConnector: PhotoSelectionConnecting {
    
    private let factory: PhotoUseCaseProducing
    
    init(factory: PhotoUseCaseProducing) {
        self.factory = factory
    }
    
    func getPhotoSelectionViewController() -> UIViewController {
        let presenter = PhotoSelectionPresenter(connector: self, factory: factory)
        let viewController = PhotoSelectionViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
