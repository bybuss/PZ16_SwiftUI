//
//  CartView.swift
//  PZ16_SwiftUI
//
//  Created by Никита Светличный on 14.05.2025.
//

import SwiftUI

struct CartView: View {
    @Binding var cartItems: [CartItem]
    @State private var usedBonuses: String = ""
    @State private var userBonuses: Int = 200
    @State private var userBalance: Int = 100000
    
    var totalPrice: Int {
        cartItems.reduce(0) { $0 + ($1.product.price_per_day * $1.days) }
    }
    
    var finalPrice: Int {
        let bonuses = Int(usedBonuses) ?? 0
        return max(totalPrice - min(bonuses, totalPrice), 0)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(cartItems.indices, id: \.self) { index in
                    HStack {
                        Text(self.cartItems[index].product.name)
                        Spacer()
                        Text("\(self.cartItems[index].days) дн.")
                        Text("\(self.cartItems[index].product.price_per_day * self.cartItems[index].days) ₽")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("Использовать бонусы:")
                    TextField("0", text: $usedBonuses)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 100)
                }
                
                Text("Итого: \(finalPrice) ₽").font(.headline)
                
                Button("Оформить аренду") {
                    self.userBalance -= self.finalPrice
                    self.userBonuses += self.cartItems.reduce(0) { $0 + $1.product.bonus_points }
                    self.userBonuses -= (Int(self.usedBonuses) ?? 0)
                    self.cartItems.removeAll()
                    self.usedBonuses = ""
                }
                .disabled(finalPrice > userBalance)
                .padding()
                .background(finalPrice > userBalance ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cartItems: .constant([
            CartItem(
                product: Product(
                    name: "Тест",
                    description: "Тест",
                    price_per_day: 10000,
                    image: "yacht_1",
                    bonus_points: 10
                ),
                days: 2
            )
        ]))
    }
}
