//
//  LoginPageModel.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 05.05.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

class LoginPageModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    @Published var registerUser: Bool = false
    @Published var reEnterPpassword: String = ""
    @Published var reEnterShowPassword: Bool = false
    
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var isMainPageShow = false
    
    var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    init() {}
    
    
    func signUp(email: String, password: String, complection: @escaping (Result<User, Error>) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                let users = Users(id: result.user.uid, name: "Ваше имя", phone: 0, adress: "Ваш адрес")
                DataBaseModel.data.setUser(user: users) { resultDB in
                    switch resultDB {
                    case .success(_):
                        complection(.success(result.user))
                    case .failure(let error):
                        complection(.failure(error))
                    }
                }
                
            } else if let error = error {
                complection(.failure(error))
            }
        }
    }
    func signIn(email: String, password: String, complection: @escaping (Result<User, Error>) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                complection(.success(result.user))
            } else if let error = error {
                complection(.failure(error))
            }
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut();
            UserDefaults.standard.set(false, forKey: "registerUser")
            
        } catch let signOutError {
            print(signOutError)
        }
    }
}
