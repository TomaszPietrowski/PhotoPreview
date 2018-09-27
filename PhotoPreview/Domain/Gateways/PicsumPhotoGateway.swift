//
//  PicsumPhotoGateway.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 27.09.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import Foundation

protocol PhotoGateway {
    func getPhotos(count: Int) -> [PhotoData]
}

final class PicsumPhotoGateway: PhotoGateway {
    
    func getPhotos(count: Int) -> [PhotoData] {
        return (1...count).map {
            PhotoData(
                imageURL: URL(string: "https://picsum.photos/2000/?image=\($0)")!,
                thumbnailURL: URL(string: "https://picsum.photos/200/?image=\($0)")!
            )
        }
    }
}
