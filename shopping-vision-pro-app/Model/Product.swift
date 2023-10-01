//
//  Item.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/23.
//

struct Product: Identifiable, Hashable, Codable {
    let productId: String
    let productName: String
    let description: String
    let price: Int
    let itemImages: [String]
    
    var id: String {
        return productId
    }
}
