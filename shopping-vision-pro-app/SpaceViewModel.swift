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
class SpaceViewModel {
    
    typealias Callback = (inout RealityViewContent) async -> Void

    var realityViewContent: RealityViewContent?

    var callback1: Callback?
    
    var callback2: Callback?    
}

@Observable
class Model3DSpaceViewModel {
    
    typealias Callback = () async -> Void

    var realityViewContent: RealityViewContent?

    var callback1: Callback?
    
    var callback2: Callback?
    
    private var contentEntity = Entity()

    func setupContentEntity() -> Entity {
        return contentEntity
    }
    
    func addEntity(entity: inout Entity, name: String, posision: SIMD3<Float>) -> Entity {
//        let entity = ModelEntity(
//            mesh: .generateBox(size: 0.5, cornerRadius: 0),
//            materials: [SimpleMaterial(color: color, isMetallic: false)],
//            collisionShape: .generateBox(size: SIMD3<Float>(repeating: 0.5)),
//            mass: 0.0
//        )

        print("debug0000 addEntity : \(name)")
        
        entity.name = name
        entity.position = posision
        entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
        entity.components.set(CollisionComponent(shapes: [ShapeResource.generateBox(size: SIMD3<Float>(repeating: 0.5))], isStatic: true))
        entity.components.set(HoverEffectComponent())

        contentEntity.addChild(entity)
        
        return entity
    }
    
    @MainActor
    func addEntityAsync(name: String, posision: SIMD3<Float>) async -> Entity? {
        print("debug0000 addEntityAsync : \(name)")
        
        do {
            
            // このusdzファイルは思った通りのドラッグができる
//            value.location3D (x: 670.4574584960938, y: -1120.55908203125, z: -1131.564208984375)
//            cube1 dragLocation : SIMD3<Float>(0.02239519, 1.0886464, -1.0305619)
//            let entity = try await ModelEntity(named: "FruitCakeSlice")
//            let entity = try await ModelEntity(named: "AirForce")
            // このファイルだけだめ
//            let entity = try await ModelEntity(named: "AirForce1XCA")
            
            
//            let entity = try await ModelEntity(named: name)
//            let entity = try await ModelEntity(named: "FruitCakeSlice", in: RealityKitContent.realityKitContentBundle)
//            let entity = try await Entity(named: "FruitCakeSlice", in: RealityKitContent.realityKitContentBundle)
//            let entity = try await ModelEntity(named: "Cake", in: RealityKitContent.realityKitContentBundle)
            
            
            // こっちのusdaファイルは思った通りのドラッグができない
            // ドラッグしようとすると手前に来てしまう
            // 自分の目の前にくる
//            value.location3D (x: 518.9124145507812, y: -1515.4285888671875, z: -317.7123718261719)
//            cube1 dragLocation : SIMD3<Float>(-0.08903499, 1.3789916, -0.43214145)
            // なんか動いた！
//            let entity = try await Entity(named: "FruitCakeSlice", in: RealityKitContent.realityKitContentBundle)
//            let entityScene = try await Entity(named: "Cake", in: RealityKitContent.realityKitContentBundle)
//            let entity = entityScene.findEntity(named: "g0")!
            
            
            // これも動いた
//            let entity = try await Entity(named: "AirForce", in: RealityKitContent.realityKitContentBundle)x
            let entity = try await Entity(named: name, in: RealityKitContent.realityKitContentBundle)

            
            print("debug0000 entity 001 : \(entity.debugDescription)")
            print("debug0000 entity entity.name : \(entity.name)")
            
            
            
            // デフォルトで標準提供されてるusdaでも同じ問題が起きる...
//            let entity = try await Entity(named: "Scene", in: RealityKitContent.realityKitContentBundle)
            // ModelEntityだとそもそもScene(usda)を読み込めない
//            let entity = try await ModelEntity(named: "CakeScene", in: RealityKitContent.realityKitContentBundle)
            // realityKitContentBundleを指定するとusdaファイルになる
            // sceneを選択することになるので
            // それだと同じ問題が起きる
//            let entity = try await Entity(named: "AirForce", in: RealityKitContent.realityKitContentBundle)
            
            // 仮説: Entityとして読み込んだSceneからSphere Entityを直接読み込めばいいのでは？？
//            let entityScene = try await Entity(named: "Scene", in: RealityKitContent.realityKitContentBundle)
//            let entity = entityScene.findEntity(named: "Sphere")!
            // いけた！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

            
            
//            let entity = try await ModelEntity(named: "CakeScene", in: realityKitContentBundle)
//            let entity = try await ModelEntity(named: "FruitCakeSlice")

            entity.name = name
            entity.position = posision
            // これだとドラッグできる
            entity.components.set(
                CollisionComponent(
                    shapes: [ShapeResource.generateSphere(radius: 20)],
                    isStatic: true
                )
            )
//            entity.components.set(
//                CollisionComponent(shapes: [.])
//            )

            entity.components.set(InputTargetComponent())
            print("debug0000 001 contentEntity.debugDescription : \(contentEntity.debugDescription)")

            // これだとドラッグできない
//            entity.components.set(
//                CollisionComponent(
//                    shapes: [ShapeResource.generateBox(size: SIMD3<Float>(repeating: 0.5))],
//                    isStatic: true
//                )
//            )
            //            entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))

            
            
            print("debug0000 002 contentEntity.debugDescription : \(contentEntity.debugDescription)")
            
            // 
            entity.components.set(HoverEffectComponent())

            contentEntity.addChild(entity)
            
            print("debug0000 contentEntity.debugDescription : \(contentEntity.debugDescription)")
            print("debug0000 entity.debugDescription : \(entity.debugDescription)")
            print("debug0000 entity.isEnabledInHierarchy : \(entity.isEnabledInHierarchy)")
            
            return entity
        } catch  {
            return nil
        }
    }
}
