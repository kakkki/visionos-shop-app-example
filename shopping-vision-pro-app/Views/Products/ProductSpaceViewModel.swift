//
//  SpaceViewModel.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

@Observable
class ProductSpaceViewModel {
    
    typealias Callback = (Product) async -> Void

    var realityViewContent: RealityViewContent?

    var callback1: Callback?
    
    var callback2: Callback?
    
    var callback3: Callback?
    
    var removeEntityCallback: (() -> Void)?
    
    var startRotation: (() -> Void)?
    
    var stopRotation: (() -> Void)?
    
    private var contentEntity = Entity()

    func setupContentEntity() -> Entity {
        return contentEntity
    }
    
    @MainActor
    func addEntityAsync(
        usdzName: String,
        entityName: String,
        posision: SIMD3<Float>
    ) async -> Entity? {
        do {
            // ModelEntityだとそもそもScene(usda)を読み込めない
//            let entity = try await ModelEntity(named: "CakeScene", in: RealityKitContent.realityKitContentBundle)
            // これだと読み込めてない
//            let entity = try await ModelEntity(named: usdzName, in: RealityKitContent.realityKitContentBundle)
//            entity.scene?.findEntity(id: <#T##Entity.ID#>)
            // これで一旦動いた
            let entity = try await Entity(named: usdzName, in: RealityKitContent.realityKitContentBundle)
            
            entity.name = entityName
            print("debug0000 entity 001 : \(entity.debugDescription)")
            print("debug0000 entity entity.name : \(entity.name)")
            entity.position = posision

            entity.components.set(
                CollisionComponent(
                    shapes: [ShapeResource.generateBox(size: SIMD3(
                        x: 15.0,
                        y: 15.0,
                        z: 15.0
                    ))],
                    isStatic: true
                )
            )
//            entity.components.set(
//                CollisionComponent(
//                    shapes: [ShapeResource.generateSphere(radius: 20)],
//                    isStatic: true
//                )
//            )
//            entity.generateCollisionShapes(recursive: true)
            
            entity.components.set(InputTargetComponent())
            entity.components.set(HoverEffectComponent())
            
            contentEntity.addChild(entity)
            print("debug0000 001 contentEntity.debugDescription : \(contentEntity.debugDescription)")

            return entity
        } catch  {
            return nil
        }
    }
}
