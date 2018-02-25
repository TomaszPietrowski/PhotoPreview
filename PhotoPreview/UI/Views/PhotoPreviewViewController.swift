//
//  PhotoPreviewViewController.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

protocol PhotoPreviewView: class {
    
}

class PhotoPreviewViewController: UIViewController, PhotoPreviewView {
    
    private let presenter: PhotoPreviewPresenter
    
    init(presenter: PhotoPreviewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
