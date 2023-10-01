//
//  LogUtils.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/23.
//

import Foundation

class LogUtils {
    
    static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // インデントと改行を挿入
        return encoder
    }()
    
    static func prettyPrint<T: Encodable>(_ value: T) {
        if let jsonData = try? jsonEncoder.encode(value),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        } else {
            print("Failed to print object: \(value)")
        }
    }
}
