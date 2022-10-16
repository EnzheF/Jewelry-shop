//
//  Users.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 14.05.2022.
//

import SwiftUI

struct Users: Identifiable {
    
    var id: String
    var name: String
    var phone: Int
    var adress: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["adress"] = self.adress
        
        return repres
    }
}
