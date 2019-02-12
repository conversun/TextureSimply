//
//  Home.swift
//  TextureSimply_Example
//
//  Created by Di on 2019/2/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

struct Home: Codable, Hashable {
    var error: Bool?
    var results: [HomeContent]?
}

struct HomeContent: Codable, Hashable {
    var id: String?
    var createdAt: String?
    var desc: String?
    var images: [String?]?
    var publishedAt: String?
    var source: String?
    var type: String?
    var url: String?
    var used: Bool?
    var who: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt
        case desc
        case images
        case publishedAt
        case source
        case type
        case url
        case used
        case who
    }
}
