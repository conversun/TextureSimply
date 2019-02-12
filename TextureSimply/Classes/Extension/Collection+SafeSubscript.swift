//
//  Collection+SafeSubscript.swift
//  TextureSimply
//
//  Created by Di on 2019/2/11.
//

import Foundation

extension Collection {
    
    public subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
