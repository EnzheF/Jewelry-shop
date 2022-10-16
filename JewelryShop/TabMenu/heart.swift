//
//  heart.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 06.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct heart: View {
    
    @ObservedObject var homeData = homeViewModel(user: LoginPageModel().currentUser!)
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                
                HStack(spacing: 20) {
                    
                    Button(action: {present.wrappedValue.dismiss()}) {
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                    }
                    Text("Избранное")
                        .font(.custom(customFont, size: 30))
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        ForEach(homeData.likedProducts) { product in
                            likedProductView(product: product)
                                .padding(.bottom, 20)
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
    func likedProductView(product: LikedProduct) -> some View {
        
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
                }
            }
        }
        .padding(20)
        .background(.white)
        .cornerRadius(15)
        .contextMenu {
            
            Button(action: {
                let index = homeData.getIndexL(product: product.product, isLikedIndex: true)
                let productIndex = homeData.getIndexL(product: product.product, isLikedIndex: false)
                
                homeData.list[productIndex].isAddedToLiked = false
                homeData.filtered[productIndex].isAddedToLiked = false
                
                homeData.likedProducts.remove(at: index)
                
            }) {
                Text("Удалить")
            }
        }
    }
}

struct heart_Previews: PreviewProvider {
    static var previews: some View {
        heart()
    }
}
