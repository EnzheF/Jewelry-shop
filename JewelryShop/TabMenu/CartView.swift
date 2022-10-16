//
//  CartView.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 07.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    
    @ObservedObject var homeData: homeViewModel
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @Environment(\.presentationMode) var present
    
    @State private var isShowAlert = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                
                HStack(spacing: 20) {
                    
                    Button(action: {present.wrappedValue.dismiss()}) {
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                    }
                    Text("Корзина")
                        .font(.custom(customFont, size: 30))
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        ForEach(homeData.basketProducts) { product in
                            basketProductView(product: product)
                                .padding(.bottom, 20)
                        }
                    }
                }
    
                VStack {
                    HStack {
                        Text("Итого: ")
                            .font(.custom(customFont, size: 25))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(homeData.calculatePrice())
                            .font(.custom(customFont, size: 25))
                    }
                    .padding([.top, .horizontal])
                    
                    Button (action: {
                        if (loginData.currentUser != nil) {
                            
                            var order = Order(userID: LoginPageModel().currentUser!.uid, date: Date(), status: "Принят")
                            order.basketProducts = self.homeData.basketProducts
                            
                            DataBaseModel.data.setOrder(order: order) { result in
                                switch result {
                                case .success(let order):
                                    print(order.cost)
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                            print("button if")
                        }
                        else {
                            self.isShowAlert = true
                            print("button else")
                        }
                        
                    })  {
                        Text("Заказать")
                            .font(.custom(customFont, size: 20).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Gold"))
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .cornerRadius(15)
                    }
                    .padding(.top, 20)
                    .alert("Для заказа необходимо авторизоваться", isPresented: $isShowAlert) {
                        Button {} label: {
                            Text("OК")
                        }
                    }
                }
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color("BGcolor"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func basketProductView(product: BasketProducts) -> some View {
        
        HStack(spacing: 15) {
            
            WebImage(url: URL(string: product.product.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 130)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(product.product.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                HStack(spacing: 15) {
                    
                    Text(homeData.getPrice(value: Float(truncating: product.product.price)))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        if product.quanity > 1 {homeData.basketProducts[homeData.getIndex(product: product.product, isBasketIndex: true)].quanity -= 1}
                    }) {
                        Image(systemName: "minus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    
                    Text("\(product.quanity)")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.black.opacity(0.06))
                    
                    Button(action: {
                        homeData.basketProducts[homeData.getIndex(product: product.product, isBasketIndex: true)].quanity += 1
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(15)
        .contextMenu {
            
            Button(action: {
                let index = homeData.getIndex(product: product.product, isBasketIndex: true)
                let productIndex = homeData.getIndex(product: product.product, isBasketIndex: false)
                
                homeData.list[productIndex].isAddedToBasket = false
                homeData.filtered[productIndex].isAddedToBasket = false
                
                homeData.basketProducts.remove(at: index)
            }) {
                Text("Удалить")
            }
        }
    }
}
