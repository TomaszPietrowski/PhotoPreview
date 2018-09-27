//
//  PhotoSelectionViewController.swift
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

protocol PhotoSelectionPresenting { }

final class PhotoSelectionPresenter: PhotoSelectionPresenting {
    
    weak var view: PhotoSelectionView!
    
    private let connector: PhotoSelectionConnecting
    private let factory: PhotoUseCaseProducing
    
    init(connector: PhotoSelectionConnecting, factory: PhotoUseCaseProducing) {
        self.connector = connector
        self.factory = factory
    }
}

protocol PhotoSelectionView: class { }

final class PhotoSelectionViewController: UICollectionViewController, PhotoSelectionView {
    
    private let presenter: PhotoSelectionPresenting
    
    init(presenter: PhotoSelectionPresenting) {
        self.presenter = presenter
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
