//
//  Service.swift
//  TextureSimply_Example
//
//  Created by Di on 2019/2/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Moya

enum Service {
    case data(type: String, page: Int)
    case day(year: Int, month: Int, day: Int)
}

extension Service: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://gank.io")!
    }
    
    var path: String {
        switch self {
        case .data(let type, let page):
            return "/api/data/\(type)/10/\(page)"
        case .day(let year, let month, let day):
            return "/api/day/\(year)/\(month)/\(day)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
 
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
