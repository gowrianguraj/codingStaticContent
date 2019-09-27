//
//  Function.swift
//  SwiftyImageCache
//
//  Created by gowri anguraj on 25/09/19.
//  Copyright © 2019 gowri anguraj. All rights reserved.
//


import Foundation

func cacheFileUrl(_ fileName: String) -> URL {
    let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    return cacheURL.appendingPathComponent(fileName)
}
