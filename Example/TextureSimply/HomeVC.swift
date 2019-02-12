//
//  HomeVC.swift
//  TextureSimply_Example
//
//  Created by Di on 2019/2/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeVC: TableNodeRefreshController<HomeContent> {
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "干货集中营"
        
        elementsEqual = { item1, item2 in
            return item1 == item2
        }
        
        requestData = { [weak self] dataHandle, context in
            guard let `self` = self else { return }
            self.page = (context == nil) ? 1 : self.page + 1
            Request.getResult(Home.self, target: Service.data(type: "all", page: self.page), complection: { result in
                if let list = result?.results {
                    dataHandle?(list)
                }
            })
        }
        
        cellNodeBlock = { item in
            return {
                return HomeCellNode(item)
            }
        }
        
    }
    
}

