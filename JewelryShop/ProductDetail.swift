//
//  ProductDetail.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 06.05.2022.
//

import SwiftUI

struct ProductDetail: View {
    var product: Product
    
    //var animation: Namespace.ID
    
    //@EnvironmentObject var data: dataModel
    var body: some View {
        
        Text("Hello")
        /*VStack {
            
            VStack {
                
                HStack {
                    
                    Button {
                        withAnimation(.easeInOut) {
                            data.showDetailProduct = false
                        }
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image("heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                    }
                }
                .padding()
                
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
                
            }
            .frame(height: 350)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.name)
                        .font(.custom(customFont, size: 20))
                    Text("Тут типо содержание и все такое...")
                        .font(.custom(customFont, size: 18).bold())
                        .padding(.top, 20)
                    
                    HStack {
                        Text("Цена: ")
                            .font(.custom(customFont, size: 20))
                        Spacer()
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                    }
                    .padding(.vertical, 20)
                    
                    Button {
                        
                    } label: {
                        Text("Добавить в корзину")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.black)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(Color("Gold")
                                            .cornerRadius(15))
                    }
                    //.padding(.top, 20)
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white
                            //.clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                            .ignoresSafeArea()
            )
        }
        .background(Color("BGcolor").ignoresSafeArea())
         */
    }
}

