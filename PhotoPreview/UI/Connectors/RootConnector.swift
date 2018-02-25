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
        let photos = (1...10).map {
            PhotoData(
                imageURL: URL(string: "https://picsum.photos/2000/?image=\($0)")!,
                thumbnailURL: URL(string: "https://picsum.photos/200/?image=\($0)")!
            )
        }
        let displayData = PhotoPreviewDisplayData(photos: photos, selectedPhotoIndex: 0)
        let connector = PhotoPreviewConnector(displayData: displayData)
        let viewController = connector.photoPreviewViewController()
        window.rootViewController = viewController
    }
}
