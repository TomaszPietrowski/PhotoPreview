//
//  KingfisherImagePrefetcher.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 26.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import Foundation
import Kingfisher

protocol ImagesPrefetcher {
    func prefetch(urls: [URL])
}

class KingfisherImagePrefetcher: ImagesPrefetcher {
    
    func prefetch(urls: [URL]) {
        ImagePrefetcher(urls: urls).start()
    }
}
