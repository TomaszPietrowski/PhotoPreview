//
//  PhotoSelectionViewController.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 27.09.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

protocol PhotoSelectionView: class { }

final class PhotoSelectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, PhotoSelectionView {
    
    private let presenter: PhotoSelectionPresenting
    
    init(presenter: PhotoSelectionPresenting) {
        self.presenter = presenter
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.viewReady()
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = Colors.PhotoSelection.background
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(PhotoSelectionCell.self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhotos
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoSelectionCell = collectionView.dequeueReusableCell(for: indexPath)
        presenter.configureCell(cell, at: indexPath.row)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelecCell(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSide = (view.frame.width - 50.0) / 3
        return CGSize(width: imageSide, height: imageSide)
    }
}
