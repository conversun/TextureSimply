//
//  NSAttributedString+Extension.swift
//  TextureSimply
//
//  Created by Di on 2019/2/11.
//

import Foundation
import UIKit

public struct AttributeConfig {
    let font: UIFont
    let color: UIColor
    let text: String
    let lineSpacing: CGFloat
    let link: URL?
    
    public init(_ text: String,
         _ color: UIColor,
         _ font: UIFont,
         _ lineSpacing: CGFloat = 0,
         _ link: URL? = nil) {
        self.text = text
        self.color = color
        self.font = font
        self.lineSpacing = lineSpacing
        self.link = link
    }
    
    var config: [NSAttributedString.Key : Any] {
        var keys: [NSAttributedString.Key : Any] = [
            .foregroundColor: color,
            .font: font,
            .paragraphStyle: NSMutableParagraphStyle().lineSpacing = lineSpacing
        ]
        if let link = self.link {
            keys[.link] = link
        }
        return keys
    }
}

public extension NSAttributedString {
    
    public convenience init(_ attributesConfig: [AttributeConfig]) {
        let mutableAttributedString = NSMutableAttributedString()
        attributesConfig.forEach {
            mutableAttributedString.append(NSAttributedString(string: $0.text, attributes: $0.config))
        }
        self.init(attributedString: mutableAttributedString)
    }
}
