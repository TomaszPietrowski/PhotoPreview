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
    
    init(in window: UIWindow) {
        self.window = window
        showMainView()
    }
    
    private func showMainView() {
        window.rootViewController = UIViewController()
    }
}
