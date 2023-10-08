//
//  ProductCardListScreen.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/22.
//

import SwiftUI

#Preview(windowStyle: .automatic) {
    ProductCardListScreen()
        .environment(TabViewModel())
}

struct ProductCardListScreen: View {
    
    // MARK: shops, products
    @State var shops = ShopRepository.shared.loadShops()
    @State var navigationPathShop: [Shop] = []

    @State var products = ProductRepository.shared.loadProducts()
    @State var navigationPathProduct: [Product] = []
    
    @Environment(TabViewModel.self) private var tabViewModel

    // 4列のGridで表示する
    let columns = [
        GridItem(.flexible()), 
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        // MARK: NavigationStack
        NavigationStack(path: $navigationPathProduct) {
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
                        }
                    }
                    
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
            .navigationTitle(tabViewModel.selectedTab.title)
            .navigationDestination(for: Product.self) { product in
                ProductDetailScreen(product: product)
                    .navigationTitle(product.productName)
            }
        }
        .onAppear {
            let data = ShopRepository.shared.loadShops()
            LogUtils.prettyPrint(data)
        }
    }
}

