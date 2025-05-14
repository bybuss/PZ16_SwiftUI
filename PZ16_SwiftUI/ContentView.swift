//
//  ContentView.swift
//  PZ16_SwiftUI
//
//  Created by Никита Светличный on 14.05.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var products: [Product] = []
    @State private var cartItems: [CartItem] = []
    @State private var selectedDays: [UUID: Int] = [:]
    
    init() {
        loadData()
    }
    
    var body: some View {
        TabView {
            BoatsView(
                cartItems: $cartItems,
                selectedDays: $selectedDays,
                products: products
            )
            .tabItem {
                Image(systemName: "map")
                Text("Катера")
            }
            
            CartView(cartItems: $cartItems)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Корзина")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Профиль")
                }
        }
    }
    
    private mutating func loadData() {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                products = try JSONDecoder().decode([Product].self, from: data)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
