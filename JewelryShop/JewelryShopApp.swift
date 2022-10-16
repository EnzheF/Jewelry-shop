//
//  JewelryShopApp.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 04.05.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct JewelryShopApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            
            if let user = LoginPageModel().currentUser {
                let homeData = homeViewModel(user: user)
                ContentView(homeData: homeData)
            } else {
                LoginPage()
            }
            //MainPage()
            //ContentView()
            //LoginPage()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            
            FirebaseApp.configure()
            
            return true
        }
    }
}
