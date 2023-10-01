//
//  ProductDetailScreen.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/24.
//

import SwiftUI
import RealityKit

// TODO: ナビゲーションバーで影がかかってしまう
struct ProductDetailScreen: View {

    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    @State var isShowImmersiveSpace: Bool = false
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    @Environment(Model3DSpaceViewModel.self) private var model3DSpaceViewModel
    
    @State var addContentCount = 0
    
    // 4列のGridで表示する
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        HStack(alignment: .top) {
            Spacer()
            // 左側のサムネと画像一覧
            VStack(alignment: .leading, spacing: 24) {
                // スワイプできるサムネ
                TabView {
                    ForEach(product.productImageNames, id: \.self) { imageName in
                        Image(imageName)
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 400, height: 400)
                        // TODO: cornerRadiusが効いてない
                          .cornerRadius(18)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                ScrollView {
                    // 画像一覧
                    LazyVGrid(columns: columns) {
                        ForEach(product.productImageNames, id: \.self) { imageName in
                            Image(imageName)
                              .resizable()
                              .aspectRatio(contentMode: .fill)
                              .frame(width: 72, height: 72)
                              .cornerRadius(8)
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 56)
            
            // 右側の情報
            VStack(alignment: .leading, spacing: 24) {
                
                HStack() {
                    Text(product.productName)
                        .font(.largeTitle)
                    Spacer()
                }
                
                HStack() {
                    Text("\(product.price)円")
                        .font(.largeTitle)
                    Spacer()
                }
                
                HStack() {
                    Text(product.description)
                        .font(.body)
                    Spacer()
                }
                // TODO: カートボタン
                // TODO: ショップ説明

                Toggle("Open Immersive Space", isOn: $isShowImmersiveSpace)
                    .onChange(of: isShowImmersiveSpace) { _, isShowing in
                        Task {
                            if isShowing {
                                await openImmersiveSpace(id: "ProductSpace")
                            } else {
                                await dismissImmersiveSpace()
                            }
                        }
                    }
                    .toggleStyle(.button)
                
                Button("add content 1") {
                    Task {
                        if let callback = model3DSpaceViewModel.callback1 {
                            await callback(product)
                        }
                    }
                }

                Button("add content 2") {
                    Task {
                        if let callback = model3DSpaceViewModel.callback2 {
                            await callback(product)
                        }
                    }
                }

                Button("add content 3") {
                    Task {
                        if let callback = model3DSpaceViewModel.callback3 {
                            await callback(product)
                        }
                    }
                }

                // TODO: Entity削除ボタン
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 98)
        .onAppear {
            LogUtils.prettyPrint(product)
        }
    }
}
