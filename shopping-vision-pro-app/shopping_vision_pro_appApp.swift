//
//  shopping_vision_pro_appApp.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/22.
//

import SwiftUI

@main
struct shopping_vision_pro_appApp: App {
    
    @State private var spaceViewModel = SpaceViewModel()
    
    @State private var cubeContainerViewModel = CubeContainerViewModel()

    @State private var model3DSpaceViewModel = Model3DSpaceViewModel()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            SampleCardListScreen()
                .environment(spaceViewModel)
                .environment(cubeContainerViewModel)
                .environment(model3DSpaceViewModel)
        }

//        ImmersiveSpace(id: "ProductSpace") {
//            ImmersiveView()
//        }
        
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
