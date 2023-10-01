//
//  SampleProductSpaceView.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/26.
//

import SwiftUI
import RealityKit

struct SampleProductSpaceView: View {
    
    @Environment(SpaceViewModel.self) private var spaceViewModel

    func addContent(content: inout RealityViewContent) async {
        print("debug0000 ProductRealityView addContent")
        let productEntity = await ProductEntity(usdzName: "FruitCakeSlice")
        await content.add(productEntity.entity)
    }
    
    func addAirForce1XCA(content: inout RealityViewContent) async {
        print("debug0000 ProductRealityView addAirForce1XCA")
        let productEntity = await ProductEntity(usdzName: "AirForce1XCA")
        await content.add(productEntity.entity)
    }

    var body: some View {
        RealityView { content in
            self.spaceViewModel.realityViewContent = content
        }
        .placementGestures(
            initialPosition: Point3D(
                [475, -2000.0, -2000.0]
//                    [0, -100.0, -100.0]
            )
        )
        .onAppear {
            self.spaceViewModel.callback1 = addContent(content:)
            self.spaceViewModel.callback2 = addAirForce1XCA(content:)
        }
    }
    
}
