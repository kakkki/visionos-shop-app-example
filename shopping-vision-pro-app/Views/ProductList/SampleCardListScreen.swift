//
//  SampleCardListScreen.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/22.
//

import SwiftUI

#Preview(windowStyle: .automatic) {
    SampleCardListScreen()
}

struct SampleCardListScreen: View {
    // TODO: リファクタ
    @State var shops = ShopRepository.shared.loadShops()
    @State var navigationPathShop: [Shop] = []

    @State var products = ProductRepository.shared.loadProducts()
    @State var navigationPathProduct: [Product] = []

    // 4列のGridで表示する
    let columns = [
        GridItem(.flexible()), 
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
//        NavigationStack(path: $navigationPathShop) {
//            SampleCardListScreenContents()
//                .navigationDestination(for: Module.self) { module in
//                    ModuleDetail(module: module)
//                        .navigationTitle(module.eyebrow)
//                }
//        }

        NavigationStack(path: $navigationPathProduct) {
//        NavigationStack(path: $navigationPathShop) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    LazyVGrid(columns: columns) {
                        ForEach(products) { product in
                            // MARK: NavigationLink
                            NavigationLink(value: product) {
                                ProductCardView(product: product)
                                /// @see: Elevate your windowed app for spatial computing
                                /// https://developer.apple.com/videos/play/wwdc2023/10110
                                    .padding(20)
                                    .contentShape(.interaction, .rect)
                                    .contentShape(.hoverEffect, .rect(cornerRadius: 16))
                                    .hoverEffect()
                            }
                            .buttonStyle(.plain)
                            /// この辺は調整がうまくいかなかった
//                            .buttonStyle(.borderless)
//                            .buttonBorderShape(.roundedRectangle(radius: 18))
                        }
                    }
                    
                    // MARK: サンプル用のStatsGrid
                    Text("Stats").font(.title)
                    /// ornamentを試しに使っただけ
//                        .ornament(attachmentAnchor: .scene(.bottom)) {
//                            Button(action: {}, label: {
//                                Text("top-1")
//                            })
//                            .glassBackgroundEffect(in: .capsule)
//                        }

                    
                    StatsGrid().padding().background(.regularMaterial, in: .rect(cornerRadius: 12))
                    StatsGrid().padding().background(.thinMaterial, in: .rect(cornerRadius: 12))
                    StatsGrid().padding().background(.thickMaterial, in: .rect(cornerRadius: 12))
                    StatsGrid().padding().background(.ultraThinMaterial, in: .rect(cornerRadius: 12))
                    StatsGrid().padding().background(.ultraThickMaterial, in: .rect(cornerRadius: 12))
                    StatsGrid().padding()
                }
                .padding(.top, 24)
                .padding(.horizontal, 48)
            }
            .navigationTitle("今日のおすすめ商品")
            .navigationDestination(for: Product.self) { product in
                ProductDetailScreen(product: product)
                    .navigationTitle(product.productName)

                
//                StatsGrid().padding().background(.regularMaterial, in: .rect(cornerRadius: 12))
                
//                ModuleDetail(module: module)
//                    .navigationTitle(module.eyebrow)
            }
        }
//        .onAppear {
//            let data = ShopRepository.shared.loadShops()
//            LogUtils.prettyPrint(data)
//        }
    }
}

