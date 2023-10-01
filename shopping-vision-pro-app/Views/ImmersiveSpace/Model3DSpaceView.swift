//
//  Model3DSpaceView.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/28.
//

import SwiftUI
import RealityKit

struct Model3DSpaceView: View {
    
    @Environment(Model3DSpaceViewModel.self) private var viewModel
    
    @State var entity1: Entity!
    @State var entity2: Entity!
    @State var entity3: Entity!
    @State var isStart: Bool = true

    // 一旦使用してない
    // @State var cubeEntities: [Entity] = []
    
    func addProductEntity1(product: Product) async {
        // AirForce.usdz
        let entityAirForce = await viewModel.addEntityAsync(
//            usdzName: "AirForce",
            usdzName: product.productUSDZ,
            entityName: "Entity1",
            posision: SIMD3(x: 0, y: 1, z: -1)
        )
        if let entityAirForce {
            entity1 = entityAirForce
        }
    }

    func addProductEntity2(product: Product) async {
        // PegasusTrail.usdz
        let entityPegasusTrail = await viewModel.addEntityAsync(
//            usdzName: "PegasusTrail",
            usdzName: product.productUSDZ,
            entityName: "Entity2",
            posision: SIMD3(x: 0.5, y: 1, z: -1)
        )
        if let entityPegasusTrail {
            entity2 = entityPegasusTrail
        }
    }
    
    func addProductEntity3(product: Product) async {
        // PegasusTrail.usdz
        let entityPegasusTrail = await viewModel.addEntityAsync(
            usdzName: product.productUSDZ,
            entityName: "Entity3",
            posision: SIMD3(x: 1, y: 1, z: -1)
        )
        if let entityPegasusTrail {
            entity3 = entityPegasusTrail
        }
    }


    var body: some View {

        RealityView { content in
            content.add(viewModel.setupContentEntity())
        } update: { content in
            print("debug0000 RealityView update")
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
                .targetedToAnyEntity()
                .onChanged { value in
                    print("debug0000 DragGesture onChanged")
                    if self.isStart {
                        isStart = false
                        return
                    }
                    let dragLocation = value.convert(
                        value.location3D, from: .local,
                        to: value.entity.parent!)

//                    if value.entity.name == "FruitCakeSlice" {
//                        entity2.position = dragLocation
//                    }
//                    if value.entity.name == "AirForce" {
//                        entity1.position = dragLocation
//                    }
//                    if value.entity.name == "PegasusTrail" {
//                        entity2.position = dragLocation
//                    }
                    
                    if value.entity.name == "Entity1" {
                        entity1.position = dragLocation
                    }
                    if value.entity.name == "Entity2" {
                        entity2.position = dragLocation
                    }
                    if value.entity.name == "Entity3" {
                        entity3.position = dragLocation
                    }

                }
                .onEnded { _ in
                    self.isStart = true
                }
        )
        .onAppear {
            self.viewModel.callback1 = addProductEntity1
            self.viewModel.callback2 = addProductEntity2
            self.viewModel.callback3 = addProductEntity3
        }
    }
}
