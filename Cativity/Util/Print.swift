//
//  Print.swift
//  Cativity
//
//  Created by Wahyu Untoro on 22/05/24.
//

import Foundation

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    #else
        Swift.print("RELEASE MODE")
    #endif
}
