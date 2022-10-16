//
//  Order.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 21.05.2022.
//

import SwiftUI
import AVFoundation
import FirebaseFirestore

struct Order {

    var id: String = UUID().uuidString
    var userID: String
    var basketProducts = [BasketProducts]()
    var date: Date
    var status: String
    
    var cost: Int {
        var sum = 0
        for basketProduct in basketProducts {
            sum += basketProduct.cost
        }
        return sum
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date)
        repres["status"] = status
        return repres
    }
    
    init(id: String = UUID().uuidString, userID: String, basketProducts: [BasketProducts] = [BasketProducts](), date: Date, status: String) {
        self.id = id
        self.userID = userID
        self.basketProducts = basketProducts
        self.date = date
        self.status = status
    }
    
    init?(doc: QueryDocumentSnapshot) {
        
        let data = doc.data()
        
        guard let id = data["id"] as? String else {return nil}
        guard let userID = data["userID"] as? String else {return nil}
        guard let date = data["date"] as? Timestamp else {return nil}
        guard let status = data["status"] as? String else {return nil}
        
        self.id = id
        self.userID = userID
        self.date = date.dateValue()
        self.status = status
    }
}
