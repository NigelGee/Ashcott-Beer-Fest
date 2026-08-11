//
//  ImageCache.swift
//  Ashcott
//
//  Created by Nigel Gee on 11/08/2026.
//

import Foundation

import UIKit

@Observable
final class ImageCache {
    private var cache = NSCache<NSString, UIImage>()

    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func insert(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func removeAll() {
        cache.removeAllObjects()
    }
}
