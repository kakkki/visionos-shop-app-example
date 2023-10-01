//
//  Shop.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/23.
//

import Foundation

struct Shop: Identifiable, Hashable, Codable {
    let shopId: String
    let shopName: String
    let isFollowed: Bool
    let shopImageNames: [String]
    let products: [Product]
    
    var id: String {
        return shopId
    }
}
