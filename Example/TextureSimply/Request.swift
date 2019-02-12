//
//  Request.swift
//  TextureSimply_Example
//
//  Created by Di on 2019/2/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Moya

class Request {
    static func getResult<T>(_ type: T.Type,
                             target: Service,
                             complection:@escaping ((T?) -> Void))
        where T: Codable {
            MoyaProvider<Service>().request(target) { result in
                if let value = result.value {
                    do {
                        let model = try value.map(type)
                        complection(model)
                    } catch let error as MoyaError {
                        print(error)
                    } catch {
                        
                    }
                }
            }
    }
}
