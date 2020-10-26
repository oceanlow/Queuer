//
//  ResultBufferedOperation.swift
//  Queuer iOS
//
//  Created by boris on 26.10.2020.
//  Copyright © 2020 Fabrizio Brancati. All rights reserved.
//

import Foundation

public enum ResultBufferedOperation {
    case success(_ data: Any)
    case failure(_ errors: [Error], _ data: Any?)
}
