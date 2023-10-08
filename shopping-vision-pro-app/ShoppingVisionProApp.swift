//
//  ShoppingVisionProApp.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/22.
//

import SwiftUI

@main
struct ShoppingVisionProApp: App {
    
    @State private var cubeContainerViewModel = CubeContainerViewModel()

    @State private var productSpaceViewModel = ProductSpaceViewModel()

    @State private var tabViewModel = TabViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabViewModel.selectedTab) {
                ForEach(TabViewModel.TabMenu.allCases) { tabItem in
                    ProductCardListScreen()
                        .environment(cubeContainerViewModel)
                        .environment(productSpaceViewModel)
                        .environment(tabViewModel)
                        .tag(tabItem)
                        .tabItem {
                            Label(tabItem.title, systemImage: tabItem.imageName)
                        }
                }
            }
        }

//        ImmersiveSpace(id: "CubeSpace") {
//            CubeSpaceView()
//                .environment(cubeContainerViewModel)
//        }

        ImmersiveSpace(id: "ProductSpace") {
            ProductSpaceView()
                .environment(productSpaceViewModel)
        }
    }
    
    init() {
        RotationSystem.registerSystem()
    }
}
