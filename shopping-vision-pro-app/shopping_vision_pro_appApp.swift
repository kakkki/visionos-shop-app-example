//
//  ShoppingVisionProApp.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/22.
//

import SwiftUI

@main
struct ShoppingVisionProApp: App {
    
    @State private var spaceViewModel = SpaceViewModel()
    
    @State private var cubeContainerViewModel = CubeContainerViewModel()

    @State private var model3DSpaceViewModel = Model3DSpaceViewModel()

    @State private var tabViewModel = TabViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabViewModel.selectedTab) {
                ForEach(TabViewModel.TabMenu.allCases) { tabItem in
                    SampleCardListScreen()
                        .environment(spaceViewModel)
                        .environment(cubeContainerViewModel)
                        .environment(model3DSpaceViewModel)
                        .environment(tabViewModel)
                        .tag(tabItem)
                        .tabItem {
                            Label(tabItem.title, systemImage: tabItem.imageName)
                        }
                }
            }
        }

//        ImmersiveSpace(id: "ProductSpace") {
//            ProductSpace()
//                .environment(spaceViewModel)
//        }

//        ImmersiveSpace(id: "ProductSpace") {
//            SampleProductSpaceView()
//                .environment(spaceViewModel)
//        }
        
//        ImmersiveSpace(id: "ProductSpace") {
//            CubeSpaceView()
//                .environment(cubeContainerViewModel)
//        }

        ImmersiveSpace(id: "ProductSpace") {
            Model3DSpaceView()
                .environment(model3DSpaceViewModel)
        }

    }
}
