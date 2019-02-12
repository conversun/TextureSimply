//
//  TextureSimply.swift
//  TextureSimply
//
//  Created by Di on 2019/2/11.
//

import Foundation
import AsyncDisplayKit

public struct SpecType {
    public static let wrapper = ASWrapperLayoutSpec.self
    public static let stack = ASStackLayoutSpec.self
    public static let inset = ASInsetLayoutSpec.self
    public static let overlay = ASOverlayLayoutSpec.self
    public static let background = ASBackgroundLayoutSpec.self
    public static let center = ASCenterLayoutSpec.self
    public static let ratio = ASRatioLayoutSpec.self
    public static let relative = ASRelativeLayoutSpec.self
    public static let absolute = ASAbsoluteLayoutSpec.self
}

public extension ASTextNode2 {
    @discardableResult
    public func title(_ title: String?,
                      _ color: UIColor = .black,
                      _ font: UIFont = UIFont.systemFont(ofSize: 14)) -> Self {
        if let title = title {
            attributedText = NSAttributedString([AttributeConfig(title, color, font, 6)])
        }
        return self
    }
    
    @discardableResult
    public func maximumNumberOfLines(_ value: UInt) -> Self {
        maximumNumberOfLines = value
        return self
    }
    
}

public extension ASTextNode {
    @discardableResult
    public func title(_ title: String?,
                      _ color: UIColor = .black,
                      _ font: UIFont = UIFont.systemFont(ofSize: 14)) -> Self {
        if let title = title {
            attributedText =
                NSAttributedString(string: title,
                                   attributes: [
                                    .foregroundColor: color,
                                    .font: font,
                                    ])
        }
        return self
    }
    
    @discardableResult
    public func maximumNumberOfLines(_ value: UInt) -> Self {
        maximumNumberOfLines = value
        return self
    }
    
}

public extension ASNetworkImageNode {
    
    @discardableResult
    public func image(_ url: String?, _ corner: CGFloat?) -> Self {
        return image(url, corner, nil, nil)
    }
    
    @discardableResult
    public func image(_ url: URL?, _ corner: CGFloat?) -> Self {
        return image(url, corner, nil, nil)
    }
    
    @discardableResult
    public func image(_ url: String?, _ corner: CGFloat?, _ width: CGFloat?, _ height: CGFloat?) -> Self {
        if let urlStr = url, let url = URL(string: urlStr) {
            image(url, corner, width, height)
        }
        return self
    }
    
    @discardableResult
    public func image(_ url: URL?, _ corner: CGFloat?, _ width: CGFloat?, _ height: CGFloat?) -> Self {
        if let url = url {
            self.url = url
            clipsToBounds = true
            contentMode = .scaleAspectFill
            placeholderEnabled = true
            placeholderFadeDuration = 0.2
            placeholderColor = UIColor.gray
        }
        
        if let corner = corner {
            cornerRadius = corner
            willDisplayNodeContentWithRenderingContext = { context, drawParameters in
                let bounds = context.boundingBoxOfClipPath
                UIBezierPath(roundedRect: bounds, cornerRadius: corner * UIScreen.main.scale).addClip()
            }
        }
        
        return self
    }
    
    
    
}

public extension ASDisplayNode {
    @discardableResult
    public func adHere(_ value: ASDisplayNode) -> Self {
        value.addSubnode(self)
        return self
    }
}

public extension ASLayoutElement {
    
    // MARK: Style
    
    @discardableResult
    public func grow(_ value: CGFloat) -> Self {
        style.flexGrow = value
        return self
    }
    
    @discardableResult
    public func shrink(_ value: CGFloat) -> Self {
        style.flexShrink = value
        return self
    }
    
    @discardableResult
    public func preferredSize(_ value: CGFloat) -> Self {
        style.preferredSize = CGSize(width: value, height: value)
        return self
    }
    
    @discardableResult
    public func preferredSize(_ size: CGSize) -> Self {
        style.preferredSize = size
        return self
    }
    
    @discardableResult
    public func preferredSize(_ width: CGFloat, _ height: CGFloat) -> Self {
        style.preferredSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    public func height(_ value: CGFloat) -> Self {
        style.height = ASDimensionMake(value)
        return self
    }
    
    @discardableResult
    public func width(_ value: CGFloat) -> Self {
        style.width = ASDimensionMake(value)
        return self
    }
    
    @discardableResult
    public func minHeight(_ value: CGFloat) -> Self {
        style.minHeight = ASDimensionMake(value)
        return self
    }
    
    @discardableResult
    public func minWidth(_ value: CGFloat) -> Self {
        style.minWidth = ASDimensionMake(value)
        return self
    }
    
    @discardableResult
    public func maxHeight(_ value: CGFloat) -> Self {
        style.maxHeight = ASDimensionMake(value)
        return self
    }
    
    @discardableResult
    public func maxWidth(_ value: CGFloat) -> Self {
        style.maxWidth = ASDimensionMake(value)
        return self
    }
    
    @discardableResult
    public func alignSelf(_ value: ASStackLayoutAlignSelf) -> Self {
        style.alignSelf = value
        return self
    }
    
    @discardableResult
    public func ascender(_ value: CGFloat) -> Self {
        style.ascender = value
        return self
    }
    
    @discardableResult
    public func descender(_ value: CGFloat) -> Self {
        style.descender = value
        return self
    }
    
    @discardableResult
    public func spacingAfter(_ value: CGFloat) -> Self {
        style.spacingAfter = value
        return self
    }
    
    // MARK: ASAbsoluteLayoutElement
    
    @discardableResult
    public func layoutPosition(_ x: CGFloat, _ y: CGFloat) -> Self {
        style.layoutPosition = CGPoint(x: x, y: y)
        return self
    }
    
    // MARK: ASOverlayLayoutSpec
    
    @discardableResult
    public func overlay(_ value: ASLayoutElement) -> ASOverlayLayoutSpec {
        return ASOverlayLayoutSpec(child: self, overlay: value)
    }
    
    // MARK: ASInsetLayoutSpec
    
    @discardableResult
    public func insets(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> ASInsetLayoutSpec {
        let edgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return ASInsetLayoutSpec(insets: edgeInsets, child: self)
    }
    
    @discardableResult
    public func insets(_ length: CGFloat) -> ASInsetLayoutSpec {
        return insets(length, length, length, length)
    }
 
    // MARK: ASRelativeLayoutSpec
    
    @discardableResult
    public func relative(_ horizontalPosition: ASRelativeLayoutSpecPosition = .start,
                         _ verticalPosition: ASRelativeLayoutSpecPosition = .start,
                         _ sizingOption: ASRelativeLayoutSpecSizingOption = .minimumSize) -> ASRelativeLayoutSpec {
        return ASRelativeLayoutSpec(horizontalPosition: horizontalPosition,
                                    verticalPosition: verticalPosition,
                                    sizingOption: sizingOption,
                                    child: self)
    }
    
    // MARK: ASRatioLayoutSpec
    
    @discardableResult
    public func ratio(_ value: CGFloat) -> ASRatioLayoutSpec {
        return ASRatioLayoutSpec(ratio: value, child: self)
    }
    
    // MARK: ASBackgroundLayoutSpec
    
    @discardableResult
    public func ratio(_ value: ASLayoutElement) -> ASBackgroundLayoutSpec {
        return ASBackgroundLayoutSpec(child: self, background: value)
    }
    
    // MARK: ASCenterLayoutSpec
    
    @discardableResult
    public func center(_ centeringOptions: ASCenterLayoutSpecCenteringOptions = .XY,
                       _ sizingOptions: ASCenterLayoutSpecSizingOptions = .minimumXY) -> ASCenterLayoutSpec {
        return ASCenterLayoutSpec(centeringOptions: centeringOptions,
                                  sizingOptions: sizingOptions,
                                  child: self)
    }
    
    // MARK: ASAbsoluteLayoutSpec
    
    @discardableResult
    public func absolute(_ specSizing: ASAbsoluteLayoutSpecSizing = .default) -> ASAbsoluteLayoutSpec {
        return ASAbsoluteLayoutSpec(sizing: specSizing, children: [self])
    }
    
    
}

public extension ASLayoutSpec {
    
    @discardableResult
    public func child<T: ASLayoutSpec>(_ type: T.Type) -> T {
        return child(type.init())
    }
    
    @discardableResult
    public func child<T: ASLayoutElement>(_ value: T) -> T {
        if let children = self.children {
            self.children = children + [value]
        } else {
            self.children = [value]
        }
        return value
    }
    
    @discardableResult
    public func addChild<T: ASLayoutSpec>(_ type: T.Type) -> T {
        return child(type.init())
    }
    
    @discardableResult
    public func addChild<T: ASLayoutElement>(_ value: T?) -> T? {
        guard let value = value else {
            return nil
        }
        if let children = self.children {
            self.children = children + [value]
        } else {
            self.children = [value]
        }
        return value
    }
    
    @discardableResult
    public func define(_ closure: (_ value: ASLayoutSpec) -> Void) -> ASLayoutSpec {
        closure(self)
        return self
    }
    
}

public extension ASStackLayoutSpec {
    @discardableResult
    public func spacing(_ value: CGFloat) -> ASStackLayoutSpec {
        spacing = value
        return self
    }
    
    @discardableResult
    public func lineSpacing(_ value: CGFloat) -> ASStackLayoutSpec {
        lineSpacing = value
        return self
    }
    
    @discardableResult
    public func direction(_ value: ASStackLayoutDirection) -> ASStackLayoutSpec {
        direction = value
        return self
    }
    
    @discardableResult
    public func horizontalAlignment(_ value: ASHorizontalAlignment) -> ASStackLayoutSpec {
        horizontalAlignment = value
        return self
    }
    
    @discardableResult
    public func verticalAlignment(_ value: ASVerticalAlignment) -> ASStackLayoutSpec {
        verticalAlignment = value
        return self
    }
    
    @discardableResult
    public func justifyContent(_ value: ASStackLayoutJustifyContent) -> ASStackLayoutSpec {
        justifyContent = value
        return self
    }
    
    @discardableResult
    public func alignContent(_ value: ASStackLayoutAlignContent) -> ASStackLayoutSpec {
        alignContent = value
        return self
    }
    
    @discardableResult
    public func alignItems(_ value: ASStackLayoutAlignItems) -> ASStackLayoutSpec {
        alignItems = value
        return self
    }
    
    @discardableResult
    public func flexWrap(_ value: ASStackLayoutFlexWrap) -> ASStackLayoutSpec {
        flexWrap = value
        return self
    }
    
}
