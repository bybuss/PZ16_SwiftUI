//
//  Product.swift
//  PZ16_SwiftUI
//
//  Created by Никита Светличный on 14.05.2025.
//

import Foundation

struct Product: Identifiable, Codable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let price_per_day: Int
    let image: String
    let bonus_points: Int
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    let days: Int
}
