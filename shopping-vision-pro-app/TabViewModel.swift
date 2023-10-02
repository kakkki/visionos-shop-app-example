//
//  TabViewModel.swift
//  shopping-vision-pro-app
//
//  Created by Atsuki Kakehi on 2023/10/02.
//

import SwiftUI
import Observation

@Observable
class TabViewModel {
    var selectedTab: TabMenu = .home
    
    enum TabMenu: String, Identifiable, CaseIterable  {
        case home = "Home"
        case search = "Search"
        
        var id: String {
            return rawValue
        }
        
        var title: String {
            switch self {
            case .home:
                return "今日のおすすめ商品"
            case .search:
                return "検索した商品"
            }
        }
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .search:
                return "magnifyingglass"
            }
        }
    }
}

