//
//  basket.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 05.05.2022.
//
/*
import SwiftUI
import SDWebImageSwiftUI

struct basket: View {
    
    @ObservedObject var homeData = homeViewModel(user: LoginPageModel().currentUser!)
    //@EnvironmentObject var homeData: homeViewModel
    //@StateObject var homeData: homeViewModel = homeViewModel()
    //@Environment(\.presentationMode) var present
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack(spacing: 20) {
                    
                    /*Button(action: {present.wrappedValue.dismiss()}) {
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.black)
                    }*/
                    Text("Корзина")
                        .font(.custom(customFont, size: 30))
                    
                    Spacer()
                    
                        .opacity(homeData.basketProducts.isEmpty ? 0 : 1)
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    /*LazyVStack(spacing: 0) {
                        ForEach(homeData.basketProducts) { product in
                            
                            Text(product.product.name)
                        }
                    }*/
                    VStack(spacing: 0) {
                        
                        ForEach(homeData.basketProducts) { prod in
                            
                            HStack(spacing: 15) {
                                
                                WebImage(url: URL(string: prod.product.image))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130, height: 130)
                                    .cornerRadius(15)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text(prod.product.name)
                                        .fontWeight(.semibold)
                                    Text(String(describing: prod.product.price))
                                        .foregroundColor(Color.green)
                                }
                            }
                        }
                    }
                }
                
                VStack {
                    
                    HStack {
                        
                        Text("Итого: ")
                            .font(.custom(customFont, size: 20))
                        
                        Spacer()
                        
                        Text(homeData.calculatePrice())
                            .font(.custom(customFont, size: 20))
                            .fontWeight(.semibold)
                    }
                    .padding([.top, .horizontal])
                    
                    Button(action: {}) {
                        
                        Text("Оплатить")
                            .font(.custom(customFont, size: 20))
                            .foregroundColor(.green)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .cornerRadius(15)
                    }
                }
                .background(Color("BGcolor")
                                .ignoresSafeArea())
            }
    
        }
        .navigationBarHidden(true)
        //.navigationBarBackButtonHidden(true)
        //.background(Color.white.ignoresSafeArea())
        .background(Color("BGcolor")
                        .ignoresSafeArea())
    }
}

struct basket_Previews: PreviewProvider {
    static var previews: some View {
        basket()
            //.environmentObject(homeViewModel())
    }
}
*/
