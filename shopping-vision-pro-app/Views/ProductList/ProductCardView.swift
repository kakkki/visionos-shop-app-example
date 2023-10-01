//
//  ProductCardView.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/10/01.
//

import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(product.productImageNames[0])
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 256.5, height: 256.5)
              .cornerRadius(18)
                            

            Text(product.productName)
                .font(.caption)
                .foregroundColor(.white)
            
            Text("\(product.price)円")
                .font(.body)
                .fontWeight(.bold)

        }
    }
}
