//
//  EmotionResult.swift
//  treena
//
//  Created by asong on 2021/09/28.
//

import Foundation

struct EmotionResult: Codable {
    var emotions: [EmotionInfo]
    
    struct EmotionInfo: Codable{
        var id: Int
        var name: String
        var type: Int
        var response: [String]
    }
}
