//
//  dataBaseModel.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 14.05.2022.
//

import SwiftUI
import FirebaseFirestore

class DataBaseModel {
    
    static let data = DataBaseModel()
    
    private var userRef: CollectionReference {
        return Firestore.firestore().collection("Users")
    }
    private var ordersRef: CollectionReference {
        return Firestore.firestore().collection("orders")
    }
    
    private init() {}
    
    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> ()) {
        self.ordersRef.getDocuments { qSnap, error in
            if let qSnap = qSnap {
                var orders = [Order]()
                for doc in qSnap.documents {
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    }/*else {
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }*/
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func setOrder(order: Order, complection: @escaping (Result<Order, Error>) -> ()) {
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                complection(.failure(error))
            } else {
                self.setBasketProducts(to: order.id, basketProducts: order.basketProducts) { result in
                    switch result {
                    case .success(let basketProducts):
                        print(basketProducts.count)
                        complection(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func setBasketProducts(to orderId: String, basketProducts: [BasketProducts],
                           complection: @escaping (Result<[BasketProducts], Error>) -> ()) {
        let basketProductsRef = ordersRef.document(orderId).collection("basketProducts")
        
        for basketProduct in basketProducts {
            basketProductsRef.document(basketProduct.id).setData(basketProduct.representation)
        }
        complection(.success(basketProducts))
    }
    
    func setUser(user: Users, completion: @escaping (Result<Users, Error>) -> ()) {
        userRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getUser(complection: @escaping (Result<Users, Error>) -> ()) {
        userRef.document(LoginPageModel().currentUser!.uid).getDocument { docSnapshot, error in
            
            guard let snap = docSnapshot else {return}
            guard let data = snap.data() else {return}
            guard let userName = data["name"] as? String else {return}
            guard let id = data["id"] as? String else {return}
            guard let phone = data["phone"] as? Int else {return}
            guard let adress = data["adress"] as? String else {return}
            
            let user = Users(id: id, name: userName, phone: phone, adress: adress)
            complection(.success(user))
        }
    }
}
