//
//  homeViewModel.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 05.05.2022.
//

import SwiftUI
import Combine
import Firebase
import FirebaseAuth

final class homeViewModel: ObservableObject {
    
    /*@Published var list2: [Product] = [
        Product(id: "1", name: "Жемчужный чокер", price: 4000, image: "Цепочки610"),
        Product(id: "2", name: "Серьги-жакеты Сферы", price: 1800, image: "Серьги330"),
        Product(id: "3", name: "Классическая цепь", price: 3500, image: "Цепочки140")
    ]*/
    //@Published var productType: ProductType = .chain
    
    @Published var list = [Product]()
    @Published var basketProducts = [BasketProducts]()
    @Published var likedProducts = [LikedProduct]()
    
    @Published var filtered: [Product] = []
    
    @Published var search = ""
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getData() {
        
        let db = Firestore.firestore()
        
        db.collection("Jewelry1").getDocuments { (snapshot, error) in
            
            if error == nil {
                if let snapshot = snapshot {
                    self.list = snapshot.documents.map { d in
                        return Product(id: d.documentID,
                                       name: d["name"] as? String ?? "",
                                       price: d["price"] as? NSNumber ?? 0,
                                       image: d["image"] as? String ?? "",
                                       category: d["category"] as? String ?? ""
                                       //cat: .chain
                        )
                    }
                }
                
            }
            else {
                
            }
            self.filtered = self.list
        }
    }
    
    func filterData() {
        
        withAnimation(.linear) {
            self.filtered = self.list.filter {
                return $0.name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    //CHECK
    /*@Published var filteredProducts: [Product] = []
    
    func filterProductsByType() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.list
                .lazy
                .filter { product in
                    return product.category == self.productType.rawValue
                }
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }*/
    //ENDCHECK
    
    func addToBasket(product: Product) {
        
        self.list[getIndex(product: product, isBasketIndex: false)].isAddedToBasket = !product.isAddedToBasket
        
        let filterIndex = self.filtered.firstIndex {(product1) -> Bool in
            return product.id == product1.id
        } ?? 0
        
        self.filtered[filterIndex].isAddedToBasket = !product.isAddedToBasket
        
        if product.isAddedToBasket {
            
            self.basketProducts.remove(at: getIndex(product: product, isBasketIndex: true))
            return
        }
        
        self.basketProducts.append(BasketProducts(product: product, quanity: 1))
        print(basketProducts)
    }
    
    func getIndex(product: Product, isBasketIndex: Bool) -> Int {
        
        let index = self.list.firstIndex { (product1) -> Bool in
            
            return product.id == product1.id
        } ?? 0
        
        let basketIndex = self.basketProducts.firstIndex { (product1) -> Bool in
            
            return product.id == product1.product.id
        } ?? 0
        
        return isBasketIndex ? basketIndex: index
    }
    
    func addToLiked(product: Product) {
        
        self.list[getIndexL(product: product, isLikedIndex: false)].isAddedToLiked = !product.isAddedToLiked
        
        let filterIndex = self.filtered.firstIndex {(product1) -> Bool in
            return product.id == product1.id
        } ?? 0
        
        self.filtered[filterIndex].isAddedToLiked = !product.isAddedToLiked
        
        if product.isAddedToLiked {
            
            self.likedProducts.remove(at: getIndexL(product: product, isLikedIndex: true))
            return
        }
        
        self.likedProducts.append(LikedProduct(product: product))
        print(likedProducts)
    }
    
    func getIndexL(product: Product, isLikedIndex: Bool) -> Int {
        
        let index = self.list.firstIndex { (product1) -> Bool in
            
            return product.id == product1.id
        } ?? 0
        
        let likedIndex = self.likedProducts.firstIndex { (product1) -> Bool in
            
            return product.id == product1.product.id
        } ?? 0
        
        return isLikedIndex ? likedIndex: index
    }
    
    func getPrice(value: Float) -> String {
        
        let format = NumberFormatter()
        format.locale = Locale(identifier: "ru_RU")
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    func calculatePrice() -> String {
        
        var price: Float = 0
        
        basketProducts.forEach { (product) in
            price += Float(product.quanity) * Float(truncating: product.product.price)
        }
        return getPrice(value: price)
    }
}

