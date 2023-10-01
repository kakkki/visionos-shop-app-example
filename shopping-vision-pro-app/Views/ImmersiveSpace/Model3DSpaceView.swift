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
    
    @State var cubeEntities: [Entity] = []
    @State var entity1: Entity!
    @State var entity2: Entity!
    @State var isStart: Bool = true

    func addCube1() async {
        // AirForce.usdz
        let entityAirForce = await viewModel.addEntityAsync(
            name: "AirForce", 
            posision: SIMD3(x: 0, y: 1, z: -1)
        )
        if let entityAirForce {
            entity1 = entityAirForce
        }
    }

    func addCube2() async {
        // PegasusTrail.usdz
        let entityPegasusTrail = await viewModel.addEntityAsync(
            name: "PegasusTrail",
            posision: SIMD3(x: 0.5, y: 1, z: -1)
        )
        if let entityPegasusTrail {
            entity2 = entityPegasusTrail
        }
    }

    var body: some View {

        RealityView { content in
            content.add(viewModel.setupContentEntity())
            // AirForce.usdz
            await addCube1()
            // PegasusTrail.usdz
            await addCube2()
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
                    if value.entity.name == "FruitCakeSlice" {
                        entity1.position = dragLocation
                    }
                    if value.entity.name == "AirForce" {
                        entity1.position = dragLocation
                    }
                    if value.entity.name == "PegasusTrail" {
                        entity2.position = dragLocation
                    }
                }
                .onEnded { _ in
                    self.isStart = true
                }
        )
        .onAppear {
            self.viewModel.callback1 = addCube1
            self.viewModel.callback2 = addCube2
        }
    }
}
