//
//  ProductSpaceView.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/28.
//

import SwiftUI
import RealityKit

struct ProductSpaceView: View {
    
    @Environment(ProductSpaceViewModel.self) private var viewModel
    
    @State var entity1: Entity!
    @State var entity2: Entity!
    @State var entity3: Entity!
    @State var isStart: Bool = true
    
    @State private var scale: Double = 1
    @State private var startScale: Double? = nil

    // 一旦使用してない
    // @State var cubeEntities: [Entity] = []
    
    // MARK: Entity追加
    func addProductEntity1(product: Product) async {
        guard entity1 == nil else { return }
        let addedEntity = await viewModel.addEntityAsync(
            usdzName: product.productUSDZ,
            entityName: "Entity1",
            posision: SIMD3(x: -0.5, y: 1.0, z: -1.5)
        )
        if let addedEntity {
            entity1 = addedEntity
        }
    }

    func addProductEntity2(product: Product) async {
        guard entity2 == nil else { return }
        let addedEntity = await viewModel.addEntityAsync(
            usdzName: product.productUSDZ,
            entityName: "Entity2",
            posision: SIMD3(x: 0.0, y: 1.0, z: -1.5)
        )
        if let addedEntity {
            entity2 = addedEntity
        }
    }
    
    func addProductEntity3(product: Product) async {
        guard entity3 == nil else { return }
        let addedEntity = await viewModel.addEntityAsync(
            usdzName: product.productUSDZ,
            entityName: "Entity3",
            posision: SIMD3(x: 0.5, y: 1.0, z: -1.5)
        )
        if let addedEntity {
            entity3 = addedEntity
        }
    }
    
    // MARK: Entity削除
    func removeAllEntities() {
        if let entity1 {
            entity1.removeFromParent()
            self.entity1 = nil
        }
        
        if let entity2 {
            entity2.removeFromParent()
            self.entity2 = nil
        }

        if let entity3 {
            entity3.removeFromParent()
            self.entity3 = nil
        }
    }

    // TODO: ローテーションボタンをProductDetailScreenから発火できるように
    // MARK: Entityを回転させる
    func startRotation() {
        if let entity1 {
            entity1.components.set(RotationComponent(speed: 0.1))
        }
        if let entity2 {
            entity2.components.set(RotationComponent(speed: 0.1))
        }
        if let entity3 {
            entity3.components.set(RotationComponent(speed: 0.1))
        }
    }

    // MARK: Entityの回転を止める
    func stopRotation() {
        if let entity1 {
            entity1.components.remove(RotationComponent.self)
        }
        if let entity2 {
            entity2.components.remove(RotationComponent.self)
        }
        if let entity3 {
            entity3.components.remove(RotationComponent.self)
        }
    }

    var body: some View {

        // MARK: RealityView
        RealityView { content in
            content.add(viewModel.setupContentEntity())
        } update: { content in
            print("debug0000 RealityView update")
            // MARK: アニメーションを動かす
            /// USDZデータに内蔵されたアニメーション
            // https://qiita.com/Shota-Abe/items/88b8de761187b46fb1cb
            // https://note.com/st_one/n/nab71d75ab3a3
            if let entity1 {
                entity1.availableAnimations.forEach {
                    entity1.playAnimation($0.repeat())
                }
            }
            if let entity2 {
                entity2.availableAnimations.forEach {
                    entity2.playAnimation($0.repeat())
                }
            }
            if let entity3 {
                entity3.availableAnimations.forEach {
                    entity3.playAnimation($0.repeat())
                }
            }
        }
        .scaleEffect(scale)
        // MARK: DragGesture
        .simultaneousGesture(
            DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
                .targetedToAnyEntity()
                .onChanged { value in
                    print("debug0000 DragGesture onChanged name : \(value.entity.name)")
//                    if self.isStart {
//                        isStart = false
//                        return
//                    }
                    let dragLocation = value.convert(
                        value.location3D, from: .local,
                        to: value.entity.parent!)

                    print("debug0000 DragGesture onChanged dragLocation : \(dragLocation)")

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
        // TODO: 調子悪いのでコメントアウト
        // MARK: MagnifyGesture
//        .simultaneousGesture(MagnifyGesture()
//            .onChanged { value in
//                print("debug0000 value.magnification : \(value.magnification)")
//                print("debug0000 value.startAnchor3D : \(value.startAnchor3D)")
//                print("debug0000 value.startLocation3D : \(value.startLocation3D)")
//                
//                
//                if let startScale {
//                    scale = max(0.1, min(3, value.magnification * startScale))
//                } else {
//                    startScale = scale
//                }
//            }
//            .onEnded { value in
//                startScale = scale
//            }
//        )
        .onAppear {
            self.viewModel.callback1 = addProductEntity1
            self.viewModel.callback2 = addProductEntity2
            self.viewModel.callback3 = addProductEntity3
            self.viewModel.removeEntityCallback = removeAllEntities
            self.viewModel.startRotation = startRotation
            self.viewModel.stopRotation = stopRotation
        }
    }
}
