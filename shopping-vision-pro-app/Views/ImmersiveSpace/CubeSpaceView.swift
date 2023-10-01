//
//  CubeSpaceView.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/28.
//

import SwiftUI
import RealityKit

struct CubeSpaceView: View {
    
    @Environment(CubeContainerViewModel.self) private var viewModel
    
    @State var cubeEntities: [ModelEntity] = []
    
    @State var isStart: Bool = true

//    @State var cube1: ModelEntity? = nil
//    @State var cube2: ModelEntity? = nil

    func addContent(content: inout RealityViewContent) async {
        print("debug0000 ProductRealityView addContent")
        let productEntity = await ProductEntity(usdzName: "FruitCakeSlice")
        await content.add(productEntity.entity)
    }

    func addCube1() {
        cubeEntities.append(viewModel.addCube(name: "Cube1", posision: SIMD3(x: 1, y: 1, z: -2), color: .red))
    }

    func addCube2() {
        cubeEntities.append(viewModel.addCube(name: "Cube2", posision: SIMD3(x: -1, y: 1, z: -2), color: .blue))
    }

    var body: some View {
        RealityView { content in
            content.add(viewModel.setupContentEntity())
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
                .targetedToAnyEntity()
                .onChanged { value in
                    if self.isStart {
                        isStart = false
                        return
                    }
                    let dragLocation = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                    print("debug0000 cube1 dragLocation : \(dragLocation)")

                    if value.entity.name == "Cube1" {
                        cubeEntities[0].position = dragLocation
                    } else if value.entity.name == "Cube2" {
                        cubeEntities[1].position = dragLocation
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
