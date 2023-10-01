//
//  FruitCakeCardView.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/24.
//

import SwiftUI

struct FruitCakeCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image("FruitCake")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 256.5, height: 256.5)
              .cornerRadius(18)
                            

            Text("ラムレーズンのフルーツケーキView")
                .font(.caption)
                .foregroundColor(.white)
            
            Text("3,500円")
                .font(.body)
                .fontWeight(.bold)

        }
    }
}
