//
//  ProfileView.swift
//  PZ16_SwiftUI
//
//  Created by Никита Светличный on 14.05.2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var userBonuses: Int = 200
    @State private var userBalance: Int = 100000
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Пользователь: Моряк").font(.headline)
            VStack(spacing: 10) {
                Text("Баланс: \(userBalance) ₽")
                Text("Бонусы: \(userBonuses)")
            }
            Spacer()
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
