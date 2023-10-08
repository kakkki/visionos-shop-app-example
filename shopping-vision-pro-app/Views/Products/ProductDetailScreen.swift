//
//  ProductDetailScreen.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/24.
//

import SwiftUI
import RealityKit

struct ProductDetailScreen: View {

    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    @State var isShowImmersiveSpace: Bool = false
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    @Environment(ProductSpaceViewModel.self) private var productSpaceViewModel
    
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
                        // TODO: AsyncImage
                        Image(imageName)
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                    }
                }
                .cornerRadius(18)
                .frame(width: 400, height: 400)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
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

                Toggle("Open Product Space", isOn: $isShowImmersiveSpace)
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

//                Toggle("Open Cube Space", isOn: $isShowImmersiveSpace)
//                    .onChange(of: isShowImmersiveSpace) { _, isShowing in
//                        Task {
//                            if isShowing {
//                                await openImmersiveSpace(id: "CubeSpace")
//                            } else {
//                                await dismissImmersiveSpace()
//                            }
//                        }
//                    }
//                    .toggleStyle(.button)

                Button("add content 1") {
                    Task {
                        if let callback = productSpaceViewModel.callback1 {
                            await callback(product)
                        }
                    }
                }

                Button("add content 2") {
                    Task {
                        if let callback = productSpaceViewModel.callback2 {
                            await callback(product)
                        }
                    }
                }

                Button("add content 3") {
                    Task {
                        if let callback = productSpaceViewModel.callback3 {
                            await callback(product)
                        }
                    }
                }

                Button("3DModelを非表示") {
                    if let callback = productSpaceViewModel.removeEntityCallback {
                        callback()
                    }
                }
                
                HStack(spacing: 24) {
                    Button("3DModelを回転") {
                        if let startRotation = productSpaceViewModel.startRotation {
                            startRotation()
                        }
                    }

                    Button("回転を止める") {
                        if let stopRotation = productSpaceViewModel.stopRotation {
                            stopRotation()
                        }
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
        .onDisappear {
            if let callback = productSpaceViewModel.removeEntityCallback {
                callback()
            }
        }
    }
}
