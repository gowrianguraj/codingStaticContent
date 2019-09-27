//
//  CGSize.swift
//  SwiftyImageCache
//
//  Created by gowri anguraj on 25/09/19.
//  Copyright © 2019 gowri anguraj. All rights reserved.
//


import UIKit

public func *(left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}

public func /(left: CGSize, right: CGFloat) -> CGSize {
    guard right != 0.0 else {
        fatalError("Can't devine by 0")
    }
    return CGSize(width: left.width / right, height: left.height / right)
}
