//
//  Images.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 28.02.2022.
//

import Foundation

struct ImageInfo: Codable {
    let urls: Urls
}

struct Urls: Codable {
    let regular: String
    var regularUrl: URL {
        return URL(string: regular)!
    }
}
