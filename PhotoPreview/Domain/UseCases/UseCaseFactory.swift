//
//  UseCaseFactory.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 27.09.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

protocol UseCaseProducing: PhotoUseCaseProducing { }

protocol PhotoUseCaseProducing {
    func getPhotosUseCase(count: Int) -> UseCase<[PhotoData]>
}

final class UseCaseFactory: UseCaseProducing {
    
    private let photoGateway: PhotoGateway
    
    init(photoGateway: PhotoGateway) {
        self.photoGateway = photoGateway
    }
    
    func getPhotosUseCase(count: Int) -> UseCase<[PhotoData]> {
        return UseCase { [photoGateway] in
            photoGateway.getPhotos(count: count)
        }
    }
}
