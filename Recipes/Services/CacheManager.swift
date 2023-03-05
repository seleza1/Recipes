//
//  CacheManager.swift
//  Recipes
//
//  Created by user on 05.03.2023.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()

    private init() {}
}

// хранятся данные по ключу и значению
