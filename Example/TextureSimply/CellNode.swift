//
//  CellNode.swift
//  TextureSimply_Example
//
//  Created by Di on 2019/2/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import TextureSimply

public class HomeCellNode: ASCellNode {
    
    var model: HomeContent?
    
    var titleNode: ASTextNode?
    var imageNode: ASNetworkImageNode?
    var bottomNode: ASTextNode?
    
    init(_ model: HomeContent? = nil) {
        self.model = model
        super.init()
        guard let model = model else { return }
        
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        selectionStyle = .none
        
        if let title = model.desc {
            titleNode = ASTextNode()
                .title(title, UIColor.darkGray)
        }
        
        if let coverImage = model.images?.first {
            imageNode = ASNetworkImageNode()
                .image(coverImage, 3)
        }
        
        if let bottom = model.who {
            bottomNode = ASTextNode()
                .title(bottom, UIColor.darkText)
        }
        
    }
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec().direction(.vertical).spacing(8).define {
            $0.addChild(SpecType.stack).direction(.horizontal).spacing(8)
                .justifyContent(.spaceBetween).alignItems(.stretch).define {
                $0.addChild(titleNode)?.grow(1).shrink(1)
                $0.addChild(imageNode)?.preferredSize(112, 63)
            }
            $0.addChild(bottomNode)
        }.insets(14)
    }
    
}
