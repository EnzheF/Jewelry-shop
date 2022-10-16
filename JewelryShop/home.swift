//
//  home.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 05.05.2022.
//
/*
import SwiftUI
import SDWebImageSwiftUI

struct home: View {
    
    @Namespace var animation
    @StateObject var homeData: homeViewModel = homeViewModel(user: LoginPageModel().currentUser!)
    //@ObservedObject var model = homeViewModel()
    @EnvironmentObject var homeData1: homeViewModel
    //@ObservedObject var homeDat = homeViewModel()
    
    //init() {
        //model.getData()
    //}
    
    //var product: Product
    //var product = Product(id: "", name: "", price: "", image: "")
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                /*HStack(spacing: 10) {
                    NavigationLink(destination: CartView(homeData: homeDat)) {
                        
                        HStack(spacing: 15) {
                            
                            Image(systemName: "cart")
                            
                            Spacer(minLength: 0)
                        }
                        .padding()
                    }
                }*/
                Divider()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Text("Soulmate")
                            .font(.custom(customFont, size: 35))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                        
                        HStack(spacing: 15) {
                            
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            TextField("Поиск", text: $homeData.search)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(
                            Capsule()
                                .strokeBorder(Color.gray, lineWidth: 0.8))
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 18) {
                                
                                ForEach(ProductType.allCases, id:\.self) { type in
                                    
                                    ProductTypeView(type: type)
                                }
                                //ForEach(model.categories) { category in
                                    
                                    //ProductTypeView(category: category)
                                //}
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.top, 30)
                        
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
                .background(Color("BGcolor"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.onAppear(perform: {
                    //homeData.getData()
                //})
                //.onChange(of: model.productType) { newValue in
                    //model.filterProductsByCategory()
                //}
                
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
            }.navigationBarHidden(true)
        }
        
        
        //.animation(.easeInOut, value: data.likedProducts)
        
        /*.overlay(
            
            ZStack {
                if homeData.searchActivated {
                    Search(animation: animation)
                        .environmentObject(homeData)
                }
            }
        )*/
    }
    
    
    
    
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        
        VStack(spacing: 10) {
            
            /*ZStack {
                if data.showDetailProduct {
                    WebImage(url: URL(string: product.image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else {
                    WebImage(url: URL(string: product.image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }*/
            HStack {
                
                Button (action: {
                    //homeData.addToLiked(product: product)
                    
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
                        //.background(product.isAddedToBasket ? Color.green : Color.black)
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
            Text(String(describing: product.price))
                .font(.custom(customFont, size: 19))
                .fontWeight(.semibold)
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 25)
        
        /*onTapGesture {
            withAnimation(.easeInOut) {
                data.detailProduct = product
                data.showDetailProduct = true
            }
        }*/
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
    //func ProductTypeView(category: Category) -> some View {
        
        Button {
            withAnimation {
                //homeData.productType = type
                //model.categories = [category]
            }
            
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 20))
                //.foregroundColor(Color.black)
                //.foregroundColor(homeData.productType == type ? Color("Gold") : Color.black)
                //.foregroundColor(model.categories == category.name ? Color("Gold") : Color.black)
                .padding(.bottom, 10)
        }
    }
    
    /*func addToLiked() {
        
        //var product: Product
        if let index = data.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            data.likedProducts.remove(at: index)
        }
        else {
            data.likedProducts.append(product)
        }
    }*/
}

struct home_Previews: PreviewProvider {
    static var previews: some View {
        home()
        //MainPage()
    }
}
*/
