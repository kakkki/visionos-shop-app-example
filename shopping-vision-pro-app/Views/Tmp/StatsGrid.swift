//
//  StatsGrid.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/09/24.
//

import SwiftUI

// MARK: StatsGrid
struct StatsGrid: View {
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 50, verticalSpacing: 10) {
            GridRow() {
                GridRow() {
                    Text("Oribital peroid").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("365.26 days").fontWeight(.light)
                }
                GridRow {
                    Text("Oribital speed").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("29.8 km/s").fontWeight(.light)
                }
                GridRow {
                    Text("Mass").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("5.9 x 10kg").fontWeight(.light).multilineTextAlignment(.trailing)
                }
            }
            GridRow {
                GridRow {
                    Text("Surface temperature").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("-89-57℃").fontWeight(.light)
                }
                GridRow {
                    Text("Equatorial radius").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("6,378km").fontWeight(.light)
                }
                GridRow {
                    Text("Age").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("4.5 billion years").fontWeight(.light)
                }
            }
        }
    }
}
