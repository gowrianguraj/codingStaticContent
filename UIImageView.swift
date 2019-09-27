//
//  UIImageView.swift
//  SwiftyImageCache
//
//  Created by gowri anguraj on 25/09/19.
//  Copyright © 2019 gowri anguraj. All rights reserved.
//


import UIKit

let UrlCacheKey = malloc(4)

extension UIImageView {
    
    public func setUrl(_ url: URL, qualityFactor: CGFloat? = nil, cache: ImageCache = .default, completion: ((UIImage?) -> Void)? = nil) {
        let fitSize = qualityFactor != nil ? bounds.size * qualityFactor! : nil
        urlCacheKey = url.absoluteString
        cache.loadImage(atUrl: url, fitSize: fitSize) { [weak self] (urlStr, image) in
            if self?.urlCacheKey == urlStr {
                self?.image = image
                completion?(image)
            }
        }
    }
    
    public func clear() {
        urlCacheKey = nil
    }
    
    fileprivate func value<T>(_ key:UnsafeMutableRawPointer?, _ defaultValue:T) -> T {
        return (objc_getAssociatedObject(self, key!) as? T) ?? defaultValue
    }
    
    private var urlCacheKey: String? {
        get {
            return value(UrlCacheKey, "")
        }
        set {
            objc_setAssociatedObject(self, UrlCacheKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}
