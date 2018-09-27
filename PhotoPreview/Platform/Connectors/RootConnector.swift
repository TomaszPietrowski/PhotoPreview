//
//  RootConnector.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

class RootConnector {
    
    private let window: UIWindow
    
    private lazy var useCaseFactory = UseCaseFactory(photoGateway: PicsumPhotoGateway())
    
    init(in window: UIWindow) {
        self.window = window
        showMainView()
    }
    
    private func showMainView() {
        let navigationController = UINavigationController()
        let connector = PhotoSelectionConnector(factory: useCaseFactory, navigationController: navigationController)
        let photoSelectionViewController = connector.getPhotoSelectionViewController()
        
        navigationController.viewControllers = [photoSelectionViewController]
        navigationController.navigationBar.isHidden = true
        
        window.rootViewController = navigationController
    }
}
