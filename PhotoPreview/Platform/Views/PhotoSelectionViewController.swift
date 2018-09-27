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

protocol PhotoSelectionPresenting {
    var numberOfPhotos: Int { get }
    func viewReady()
    func configureCell(_ cell: PhotoSelectionCell, at index: Int)
    func didSelecCell(at index: Int)
}

final class PhotoSelectionPresenter: PhotoSelectionPresenting {
    
    weak var view: PhotoSelectionView!
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    private let connector: PhotoSelectionConnecting
    private let factory: PhotoUseCaseProducing
    private let imageLoader: ImageLoader
    private var photos: [PhotoData] = []
    
    init(connector: PhotoSelectionConnecting, factory: PhotoUseCaseProducing, imageLoader: ImageLoader = KingfisherImageLoader()) {
        self.connector = connector
        self.factory = factory
        self.imageLoader = imageLoader //TODO: Pass image loader and remove default value
    }
    
    func viewReady() {
        photos = factory.getPhotosUseCase(count: 24).execute()
    }
    
    func configureCell(_ cell: PhotoSelectionCell, at index: Int) {
        cell.displayImage(photos[index].thumbnailURL, imageLoader: imageLoader)
    }
    
    func didSelecCell(at index: Int) {
        //TODO: Show photo preview
    }
}

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

final class PhotoSelectionCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.PhotoSelection.photoBackground
        setupImageView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        let constraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        contentView.addSubview(imageView, with: constraints)
    }
    
    func displayImage(_ imageURL: URL, imageLoader: ImageLoader) {
        imageView.setImage(using: imageURL, imageLoader: imageLoader)
    }
}
