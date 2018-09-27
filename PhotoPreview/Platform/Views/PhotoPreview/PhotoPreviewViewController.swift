//
//  PhotoPreviewViewController.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

protocol PhotoPreviewView: class {
    func scrollToPhoto(at index: Int)
}

class PhotoPreviewViewController: UIViewController, PhotoPreviewView, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.PhotoPreview.background
        collectionView.register(PhotoPreviewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.prefetchDataSource = self
        return collectionView
    }()
    
    private let layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.itemSize = UIScreen.main.bounds.size
        return flowLayout
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "closeIcon"), for: .normal)
        return button
    }()
    
    private let presenter: PhotoPreviewPresenting
    
    init(presenter: PhotoPreviewPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCloseButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.viewReady()
    }
    
    func scrollToPhoto(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView, with: [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.dataSource = self
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton, with: [
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            closeButton.heightAnchor.constraint(equalToConstant: 24.0),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        ])
        
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    @objc private func didTapCloseButton() {
        presenter.didSelectCloseButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoPreviewCell = collectionView.dequeueReusableCell(for: indexPath)
        presenter.configureCell(cell, at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        presenter.prefetchItems(at: indexPaths)
    }
}
