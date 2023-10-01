//
//  ProductDetailScreen.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/24.
//

import SwiftUI
import RealityKit

// TODO: ナビゲーションバーで影がかかってしまう
struct ProductDetailScreen: View {

    let product: Product

    private let teapotURL = URL(string: "https://developer.apple.com/augmented-reality/quick-look/models/teapot/teapot.usdz")!

    // TODO: 商品に紐づくショップ説明
    
    init(product: Product) {
        self.product = product
    }
    
    @State var isShowImmersiveSpace: Bool = false
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    @Environment(SpaceViewModel.self) private var spaceViewModel
    
    @Environment(Model3DSpaceViewModel.self) private var model3DSpaceViewModel
    
    @Environment(CubeContainerViewModel.self) private var cubeContainerViewModel
    
    @State var addContentCount = 0
    
    var body: some View {
        HStack(alignment: .top) {
            // 左側のサムネと画像一覧
            VStack(alignment: .center) {
                Image("FruitCake")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 400, height: 400)
                  .cornerRadius(18)
                
                // TODO: 画像一覧
                
                Spacer()
            }
            .padding(.trailing, 56)
//            .background(.blue)
            
            // 右側の情報
            VStack(alignment: .leading, spacing: 24) {
                
                Toggle("Open Immersive Space", isOn: $isShowImmersiveSpace)
                    .onChange(of: isShowImmersiveSpace) { _, isShowing in
                        Task {
                            if isShowing {
                                await openImmersiveSpace(id: "ProductSpace")
                            } else {
                                await dismissImmersiveSpace()
                            }
                        }
                    }
                    .toggleStyle(.button)
                
                Button("add content") {
//                    if addContentCount == 0 {
//                        cubeContainerViewModel.callback1!()
//                    } else {
//                        cubeContainerViewModel.callback2!()
//                    }

                    
//                    Task {
//                        if addContentCount == 0 {
//                            await spaceViewModel.callback1!(&spaceViewModel.realityViewContent!)
//                        } else {
//                            await spaceViewModel.callback2!(&spaceViewModel.realityViewContent!)
//                        }
//                    }
                    print("debug0000 add content addContentCount : \(addContentCount)")

                    Task {
                        if addContentCount == 0 {
                            print("debug0000 before model3DSpaceViewModel.callback1!()")
                            await model3DSpaceViewModel.callback1!()
                        } else {
                            print("debug0000 before model3DSpaceViewModel.callback2!()")
                            await model3DSpaceViewModel.callback2!()
                        }
                        addContentCount += 1
                    }
                }

                
                HStack() {
                    Text(product.productName)
                        .font(.largeTitle)
                    Spacer()
                }
                
                HStack() {
                    Text("\(product.price)")
                        .font(.largeTitle)
                    Spacer()
                }
                
                HStack() {
                    Text(product.description)
                        .font(.body)
                    Spacer()
                }
                // TODO: カートボタン
                // TODO: ショップ説明
                
//                Model3D(url: teapotURL) { model in
//                    model
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 200, height: 200)
//                } placeholder: {
//                    ProgressView()
//                }
//                
//                Model3D(named: "FruitCakeSlice") { model in
//                    model
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 200, height: 200)
//
//                } placeholder: {
//                    ProgressView()
//                }

                
                // いい感じに表示できてたやつ
//                RealityView { content in
//                    let rootEntity = setupEntity()
////                    let entity = Model3D(named: "FruitCakeSlice")
//                    
//                    entity = try! await ModelEntity(named: "FruitCakeSlice")
//                    entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
//                    entity.components.set(CollisionComponent(shapes: [ShapeResource.generateSphere(radius: 20)], isStatic: true))
//
//                    
//                    
//                    rootEntity.addChild(entity)
//                    content.add(rootEntity)
//                }
//                .gesture(
//                    DragGesture()
//                        .targetedToEntity(entity)
//                        .onChanged { value in
//                            entity.position = value.convert(value.location3D, from: .local, to: entity.parent!)
//                        }
//                )

//                .gesture(
//                    SpatialTapGesture(count: 2)
//                        .targetedToAnyEntity()
//                        .onEnded { value in
////                            model.addAxis(value: value)
//                        }
//                )

                Spacer()

            }
//            .background(.red)
            
            Spacer()

        }
        .padding(.horizontal, 98)
//        .background(.purple)

    }
    
    @State var entity = Entity()
    
    func setupEntity() -> Entity {
        var contentEntity = Entity()
        contentEntity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
        contentEntity.components.set(CollisionComponent(shapes: [ShapeResource.generateSphere(radius: 20)], isStatic: true))
        return contentEntity
    }
}
