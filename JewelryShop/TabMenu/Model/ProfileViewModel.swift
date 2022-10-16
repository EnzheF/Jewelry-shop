//
//  ProfileViewModel.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 14.05.2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var profile: Users
    @Published var orders: [Order] = [Order]()
    
    init(profile: Users) {
        self.profile = profile
    }
    
    func getOrders() {
        DataBaseModel.data.getOrders(by: LoginPageModel().currentUser?.uid) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                print("Всего заказов: \(orders.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setProfile() {
        
        DataBaseModel.data.setUser(user: self.profile) { result in
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print("Ошибка отправки данных\(error.localizedDescription)")
            }
        }
    }
    
    func getProfile() {
        
        DataBaseModel.data.getUser { result in
            switch result {
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func discount() -> Int {
        if orders.count < 10 {
            return orders.count
        }
        else {
            return 10
        }
    }
}
