//
//  ShopRepository.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/23.
//

import Foundation

class ShopRepository {
    
    static let shared = ShopRepository()
    
    static let fileName = "shops_data"
    
    private init() {}
    
    // ショップのリストを取得する関数
    func loadShops() -> [Shop] {
//        let filename = "your_file_name_without_extension"
//        let filename = sampleDataFileName
        
        guard let url = Bundle.main.url(forResource: Self.fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let shops = try? JSONDecoder().decode([Shop].self, from: data) else {
            print("Failed to load the shops from JSON data.")
            return []
        }
        
        return shops.sorted(by: { $0.shopId < $1.shopId })
    }
}

class ProductRepository {
    
    static let shared = ProductRepository()
    
    static let fileName = "shops_data"

    private init() {}
    
    // 商品のリストを取得する関数
    func loadProducts() -> [Product] {
//        let filename = "your_file_name_without_extension"
//        let filename = sampleDataFileName

        guard let url = Bundle.main.url(forResource: Self.fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let shops = try? JSONDecoder().decode([Shop].self, from: data) else {
            print("Failed to load the products from JSON data.")
            return []
        }
        
        return shops.flatMap { $0.products }.sorted(by: { $0.productId < $1.productId })
    }
}
