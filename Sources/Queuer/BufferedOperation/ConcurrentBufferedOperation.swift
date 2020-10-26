//
//  ConcurrentBufferedOperation.swift
//  Queuer iOS
//
//  Created by boris on 26.10.2020.
//  Copyright © 2020 Fabrizio Brancati. All rights reserved.
//

import Foundation

public protocol OperationBuffer {
    var input: ResultBufferedOperation? { get }
    var output: ResultBufferedOperation? { get set }
}

open class ConcurrentBufferedOperation: ConcurrentOperation, OperationBuffer {
    private var _input: ResultBufferedOperation?
    public var input: ResultBufferedOperation? {
        if _input != nil {
            return _input
        } else {
            return getDependency()?.output
        }
    }
    public var output: ResultBufferedOperation?
    
    public init(_ input: ResultBufferedOperation? = nil) {
        _input = input
        super.init()
    }
}

extension OperationBuffer where Self: ConcurrentBufferedOperation {
    public func previousDependency() -> OperationBuffer? {
        let index = dependencies.firstIndex{$0 === self}
        if let index = index, index > 0 {
            let previousDependency = dependencies[index-1]
            return previousDependency as? OperationBuffer
        }
        return nil
    }
    
    public func nextDependency() -> OperationBuffer? {
        let index = dependencies.firstIndex{$0 === self}
        if let index = index, index < dependencies.count {
            let nextDependency = dependencies[index+1]
            return nextDependency as? OperationBuffer
        }
        return nil
    }
    
    public func getDependency() -> OperationBuffer? {
        let getDependency = dependencies.first
        return getDependency as? OperationBuffer
    }
}
