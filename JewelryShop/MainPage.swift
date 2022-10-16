//
//  MainPage.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 04.05.2022.
//
/*
import SwiftUI

struct MainPage: View {
    
    @State var currentTab: Tab = .home
    @ObservedObject var homeData = homeViewModel(user: LoginPageModel().currentUser!)
    @StateObject var homeModel = homeViewModel(user: LoginPageModel().currentUser!)
    
    
    //@StateObject var data: dataModel = dataModel()
    
        //@Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
            VStack(spacing: 0) {
            
            TabView(selection: $currentTab) {
                    home()
                        .tag(Tab.home)
                    heart()
                        .tag(Tab.heart)
                    LoginPage()
                        .tag(Tab.profile)
                    CartView(homeData: homeData)
                        //.environmentObject(homeData)
                        .tag(Tab.basket)
            }
                
            
           HStack(spacing: 10) {
                ForEach(Tab.allCases, id: \.self) {tab in
                    
                    //ПРАВИЛЬНОЕ ОСТАВИТЬ
                    Button {
                        currentTab = tab
                        
                    } label: {
                        
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.black : Color.black.opacity(0.5))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
            
                
                
            
        }
        
        /*.overlay(
            ZStack {
                if let product = data.detailProduct, data.showDetailProduct {
                    ProductDetail(product: product, animation: animation)
                        .environmentObject(data)
                }
            }
        )*/
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
.previewInterfaceOrientation(.portrait)
    }
}

enum Tab: String, CaseIterable {
    case home = "home"
    case heart = "heart"
    case profile = "profile"
    case basket = "basket"
}
*/

/*import SwiftUI

struct MainPage: View {
    
    @ObservedObject var homeData = homeViewModel(user: LoginPageModel().currentUser!)
    
    var body: some View {
        
        TabView {
            ContentView()
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("home")
                    }
                }
            NavigationLink(destination: heart(homeData:homeData).navigationBarHidden(true), label: {
                VStack {
                    Image(systemName: "heart")
                    Text("heart")
                }
                })
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("heart")
                    }
                }
            LoginPage()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("profile")
                    }
                }
            NavigationView{
                CartView(homeData: homeData)
            }
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("basket")
                    }
                }
        }
    }
}*/
