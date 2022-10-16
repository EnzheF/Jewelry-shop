//
//  ContentView.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 04.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var homeData = homeViewModel(user: LoginPageModel().currentUser!)
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        Text("Soulmate")
                            .font(.custom(customFont, size: 35))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                        
                        HStack(spacing: 15) {
                            
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                                .foregroundColor(.gray)
                            
                            TextField("Поиск", text: $homeData.search)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(
                            Capsule()
                                .strokeBorder(Color.gray, lineWidth: 0.8))
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 25) {
                                
                                ForEach(homeData.filtered) { product in
                                    
                                    ProductCardView(product: product)
                                }
                            }
                            .padding(.horizontal, 65)
                        }
                    }
                    .padding()
                }
                
                VStack{
                HStack(spacing: 40) {
                        Image("home")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.black)
                    NavigationLink(destination: heart(homeData:homeData).navigationBarHidden(true), label: {
                        Image("heart")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.black)
                        })
                    if let user = LoginPageModel().currentUser {
                        NavigationLink(destination: profile(viewModel: ProfileViewModel(profile: Users(id: "", name: "", phone: 0000000000, adress: ""))).navigationBarHidden(true), label: {
                            Image("profile")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
                            })
                    }
                    else {
                        NavigationLink(destination: LoginPage().navigationBarHidden(true), label: {
                            Image("profile")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
                            })
                    }
                    NavigationLink(destination: CartView(homeData:homeData).navigationBarHidden(true), label: {
                        Image("basket")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.black)
                        })
                }
                .padding(.horizontal)
                .padding(.top, 25)
                .navigationBarHidden(true)
                .background(Color.white)
            }
                .background(Color.white)
            }
            .onAppear(perform: {
                homeData.getData()
            })
            .onChange(of: homeData.search, perform: { value in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if value == homeData.search && homeData.search != "" {
                        homeData.filterData()
                    }
                }
                if homeData.search == "" {
                    withAnimation(.linear){homeData.filtered = homeData.list}
                }
            })
            .background(Color("BGcolor"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {

            HStack {
                
                Button (action: {
                    homeData.addToLiked(product: product)
                    
                }, label: {
                    Image(product.isAddedToLiked ? "heartClicked" : "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                })
                Spacer()
                
                Button(action: {
                    homeData.addToBasket(product: product)
                    
                }, label: {
                    Image(product.isAddedToBasket ? "basketClicked" : "basket")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                })
            }
            .padding(20)
            .padding(.top, 15)
            
            WebImage(url: URL(string: product.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text(product.name)
                .font(.custom(customFont, size: 20))
                .padding(.top)
            Text("\(String(describing: product.price)) ₽")
                .font(.custom(customFont, size: 19))
                .fontWeight(.semibold)
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(Color.white.cornerRadius(25))
        .padding(.top, 25)
    }
    
}
