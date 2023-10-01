//
//  SampleCardListScreenContents.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/24.
//

import SwiftUI

struct SampleCardListScreenContents: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {

                Grid(alignment: .leading, horizontalSpacing: 36, verticalSpacing: 20) {
                    GridRow() {
                        FruitCakeCard1
                        FruitCakeCard2
                        FruitCakeCard2
                        FruitCakeCard2
                    }

                    GridRow() {
                        Image("FruitCake")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 256.5, height: 256.5)
                          .cornerRadius(18)

                        Image("FruitCake")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 256.5, height: 256.5)
                          .cornerRadius(18)

                    }
                }
                
                // contentMode: .fill なら縦横比を keepする
                Image("FruitCake")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 256.5, height: 256.5)
//                      .clipped()
                  .cornerRadius(18)

                
                Text("Stats").font(.title)
                StatsGrid().padding()
                StatsGrid().padding().background(.regularMaterial, in: .rect(cornerRadius: 12))
                StatsGrid().padding().background(.thinMaterial, in: .rect(cornerRadius: 12))
                StatsGrid().padding().background(.thickMaterial, in: .rect(cornerRadius: 12))
                StatsGrid().padding().background(.ultraThinMaterial, in: .rect(cornerRadius: 12))
                StatsGrid().padding().background(.ultraThickMaterial, in: .rect(cornerRadius: 12))
            }
            .padding(.top, 48)
            .padding(.leading, 48)
        }
        .navigationTitle("Hoge Hoge")
//        .padding(.leading, 48)
    }
}

extension SampleCardListScreenContents {
    // MARK: FruitCakeCard1
    var FruitCakeCard1: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image("FruitCake")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 256.5, height: 256.5)
              .cornerRadius(18)
                            

            Text("ラムレーズンのフルーツケーキ1")
                .font(.caption)
                .foregroundColor(.white)
            
            Text("3,500円")
                .font(.body)
                .fontWeight(.bold)

        }
    }

    // MARK: FruitCakeCard2
    var FruitCakeCard2: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image("FruitCake")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 256.5, height: 256.5)
              .cornerRadius(12)
                            
            Text("ラムレーズンのフルーツケーキ2")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.leading, 8)
            
            Text("3,500円")
                .font(.body)
                .fontWeight(.bold)
                .padding(.leading, 8)
                .padding(.bottom, 8)
        }
        .background(.regularMaterial, in: .rect(cornerRadius: 12))
            .foregroundStyle(.white)

    }
}
