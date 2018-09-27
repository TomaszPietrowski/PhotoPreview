//
//  PhotoSelectionConnector.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 27.09.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

protocol PhotoSelectionConnecting {
    func showPhotoPreview(displayData: PhotoPreviewDisplayData)
}

final class PhotoSelectionConnector: PhotoSelectionConnecting {
    
    private let factory: PhotoUseCaseProducing
    private weak var navigationController: UINavigationController!
    
    init(factory: PhotoUseCaseProducing, navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController = navigationController
    }
    
    func getPhotoSelectionViewController() -> UIViewController {
        let presenter = PhotoSelectionPresenter(connector: self, factory: factory)
        let viewController = PhotoSelectionViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
    
    func showPhotoPreview(displayData: PhotoPreviewDisplayData) {
        let connector = PhotoPreviewConnector(displayData: displayData)
        let viewController = connector.photoPreviewViewController()
        
        connector.onDismiss = { [viewController] in
            viewController.dismiss(animated: true, completion: nil)
        }
        
        navigationController?.present(viewController, animated: true, completion: nil)
    }
}
