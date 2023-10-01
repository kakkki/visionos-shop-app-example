//
//  ProductSpace.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/25.
//

import SwiftUI
import RealityKit

class ProductEntity: Entity {
    
    var entity: Entity
    
    // MARK: - Initializers

    /// Creates a new blank earth entity.
    @MainActor required init() {
        print("debug0000 ProductEntity.init 001")
        entity = ProductEntity()
//        pole = Entity()
//        moon = SatelliteEntity()
        super.init()
    }

    init(usdzName: String) async {
        print("debug0000 ProductEntity.init 002 hoge")
        do { // Load assets.
            entity = try await ModelEntity(named: usdzName)
            entity.components.set(
                InputTargetComponent(allowedInputTypes: .indirect)
            )
            entity.components.set(
                CollisionComponent(
                    shapes: [ShapeResource.generateSphere(radius: 20)],
                    isStatic: true
                )
            )
            entity.name = usdzName
        } catch {
            fatalError("debug0000 Failed to load a model asset.")
        }
        super.init()

    }
}

struct ProductRealityView: View {

//    @Environment(SpaceViewModel.self) private var spaceViewModel
    
    @State var spaceViewModel: SpaceViewModel
    
    @State private var contentEntity: ProductEntity?
    
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

    // TODO: Entityの種類毎に座標をずらす
    // TODO: それぞれ別々にDragできるようにしたい
    // TODO: RealityViewにおける空間座標の理解を深めたい
    init(spaceViewModel: SpaceViewModel) {
        self.spaceViewModel = spaceViewModel
        self.spaceViewModel.callback1 = addContent(content:)
        self.spaceViewModel.callback2 = addAirForce1XCA(content:)
    }
    
    var body: some View {
        RealityView { content in
            print("debug0000 ProductRealityView 001")
            self.spaceViewModel.realityViewContent = content
            
            await addContent(content: &content)
//            await addAirForce1XCA(content: &content)
            
            // Create an earth entity with tilt, rotation, a moon, and so on.
//            await addContent(content: &content)
            
//            let productEntity = await ProductEntity(tmpArgument: "tmp")

//            self.contentEntity?.addChild(productEntity.entity)
//            content.add(productEntity.entity)

//             Store for later updates.
//            self.contentEntity = productEntity

            // Store for later updates.
//            self.contentEntity = productEntity
//            self.contentEntity?.components.set(
//                InputTargetComponent(allowedInputTypes: .indirect)
//            )
//            self.contentEntity?.components.set(
//                CollisionComponent(
//                    shapes: [ShapeResource.generateSphere(radius: 20)],
//                    isStatic: true
//                )
//            )
//            
//            self.contentEntity?.addChild(productEntity.entity)
//            content.add(self.contentEntity!)
            

        }
//    update: { content in
//            // Reconfigure everything when any configuration changes.
//            productEntity?.update(
//                configuration: earthConfiguration,
//                satelliteConfiguration: satelliteConfiguration,
//                moonConfiguration: moonConfiguration,
//                animateUpdates: animateUpdates
//            )
//        }

    }
}

struct ProductSpace: View {
    
    @Environment(SpaceViewModel.self) private var spaceViewModel
    
    var body: some View {
        ProductRealityView(spaceViewModel: spaceViewModel)
            .placementGestures(
                initialPosition: Point3D(
                    [475, -1600.0, -2000.0]
//                    [0, -100.0, -100.0]
                )
            )
//            .environment(spaceViewModel)
        // TODO: isShow
//        .onDisappear {
//            model.isShowingOrbit = false
//        }
    }

}

#Preview {
    ProductSpace()
}
