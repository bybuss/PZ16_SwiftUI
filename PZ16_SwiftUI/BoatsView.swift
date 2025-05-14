//
//  BoatsView.swift
//  PZ16_SwiftUI
//
//  Created by Никита Светличный on 14.05.2025.
//

import SwiftUI

struct BoatsView: View {
    @Binding var cartItems: [CartItem]
    @Binding var selectedDays: [UUID: Int]
    let products: [Product]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(products) { product in
                    VStack(alignment: .leading, spacing: 10) {
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                        
                        Text(product.name).font(.headline)
                        Text(product.description).font(.subheadline)
                        Text("\(product.price_per_day) ₽/день").foregroundColor(.green)
                        
                        HStack {
                            Button(action: { self.decreaseDays(for: product) }) {
                                Image(systemName: "minus.circle")
                            }
                            Text("\(self.selectedDays[product.id] ?? 0)")
                            Button(action: { self.increaseDays(for: product) }) {
                                Image(systemName: "plus.circle")
                            }
                            Spacer()
                            Button("В корзину") { self.addToCart(product: product) }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    
    private func addToCart(product: Product) {
        guard let days = selectedDays[product.id], days > 0 else { return }
        cartItems.append(CartItem(product: product, days: days))
        selectedDays[product.id] = 0
    }
    
    private func increaseDays(for product: Product) {
        selectedDays[product.id] = (selectedDays[product.id] ?? 0) + 1
    }
    
    private func decreaseDays(for product: Product) {
        if let count = selectedDays[product.id], count > 0 {
            selectedDays[product.id] = count - 1
        }
    }
}

struct BoatsView_Previews: PreviewProvider {
    static var previews: some View {
        BoatsView(
            cartItems: .constant([]),
            selectedDays: .constant([:]),
            products: [
                Product(
                    name: "Тестовая яхта",
                    description: "Описание",
                    price_per_day: 10000,
                    image: "yacht_1",
                    bonus_points: 10
                ),
                Product(
                    name: "Тестовая яхта 2",
                    description: "Описание",
                    price_per_day: 10000,
                    image: "yacht_2",
                    bonus_points: 10
                )
            ]
        )
    }
}
