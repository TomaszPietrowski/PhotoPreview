//
//  UseCase.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 27.09.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

protocol Executable {
    associatedtype Result
    func execute() -> Result
}

class UseCase<T>: Executable {
    
    typealias ExecutionBlock = () -> T
    private let onExecute: ExecutionBlock
    
    init(onExecute: @escaping ExecutionBlock) {
        self.onExecute = onExecute
    }
    
    func execute() -> T {
        return onExecute()
    }
}
