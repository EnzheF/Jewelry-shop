//
//  Products.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 04.05.2022.
//

import SwiftUI

struct Product: Identifiable {
    var id: String
    var name: String
    var price: NSNumber
    var image: String
    var category: String

    var isAddedToBasket: Bool = false
    var isAddedToLiked: Bool = false
}

struct BasketProducts: Identifiable {
    
    var id = UUID().uuidString
    var product: Product
    var quanity: Int
    
    var cost: Int {
        return Int(truncating: product.price) * self.quanity
    }
    
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        
        repres["id"] = id
        repres["quanity"] = quanity
        repres["name"] = product.name
        repres["price"] = product.price
        repres["cost"] = self.cost
        
        return repres
    }
}

struct LikedProduct: Identifiable {
    
    var id = UUID().uuidString
    var product: Product
}
