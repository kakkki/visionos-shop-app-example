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
            VStack(alignment: .leading, spacing: 12) {
                // スワイプできるサムネ
                TabView {
                    ForEach(product.productImageNames, id: \.self) { imageName in
                        Image(imageName)
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 400, height: 400)
                          .cornerRadius(18)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
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
//                .background(.blue)

                Spacer()
            }
            .padding(.horizontal, 56)
//            .background(.purple)

            
            // 右側の情報
            VStack(alignment: .leading, spacing: 24) {
                
                HStack() {
                    Text(product.productName)
                        .font(.largeTitle)
                    Spacer()
                }
                
                HStack() {
                    Text("\(product.price)")
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
                    print("debug0000 add content addContentCount : \(addContentCount)")
                    Task {
//                        if addContentCount == 0 {
//                            print("debug0000 before model3DSpaceViewModel.callback1!()")
//                            await model3DSpaceViewModel.callback1!()
//                        } else {
//                            print("debug0000 before model3DSpaceViewModel.callback2!()")
//                            await model3DSpaceViewModel.callback2!()
//                        }
//                        addContentCount += 1
                        await model3DSpaceViewModel.callback1!(product)
                    }
                }

                Button("add content 2") {
                    Task {
                        await model3DSpaceViewModel.callback2!(product)
                    }
                }

                Button("add content 3") {
                    Task {
//                        await model3DSpaceViewModel.callback2!(product)
                        await model3DSpaceViewModel.callback3!(product)
                    }
                }

                
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
