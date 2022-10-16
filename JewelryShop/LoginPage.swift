//
//  LoginPage.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 05.05.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

let customFont = "Montserrat-Regular"

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @Environment(\.presentationMode) var present
    var body: some View {
        
        VStack {
            HStack(spacing: 20) {
                
                Button(action: {present.wrappedValue.dismiss()}) {
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }
                Spacer()
            }.padding(.top, 30)
                .padding(.leading, 20)
            
            Text("Soulmate")
                .font(.custom(customFont, size: 40))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.top, 45)
            
            Text("Добро пожаловать")
                .font(.custom(customFont, size: 28))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.top, 30)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15) {
                    Text(loginData.registerUser ? "Регистрация" : "Авторизация")
                        .font(.custom(customFont, size: 20).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(icon: "envelope", title: "Электронная почта", hint: "test@test.ru", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Пароль", hint: "Password123", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 30)
                    
                    if loginData.registerUser {
                        CustomTextField(icon: "lock", title: "Подтвердите пароль", hint: "Password123", value: $loginData.reEnterPpassword, showPassword: $loginData.reEnterShowPassword)
                            .padding(.top, 30)
                    }
                    Button {
                        if loginData.registerUser {
                            
                            guard loginData.password == loginData.reEnterPpassword else {
                                self.loginData.alertMessage = "Пароли не совпадают!"
                                self.loginData.isShowAlert.toggle()
                                return
                            }
                            loginData.signUp(email: self.loginData.email, password: self.loginData.password) { result in
                                switch result {
                                case.success(_):
                                    loginData.alertMessage = "Регистрация прошла успешно"
                                    self.loginData.isShowAlert.toggle()
                                    self.loginData.email = ""
                                    self.loginData.password = ""
                                    self.loginData.reEnterPpassword = ""
                                    self.loginData.registerUser.toggle()
                                case.failure(let error):
                                    loginData.alertMessage = "Ошибка регистрации: \(error.localizedDescription)"
                                    self.loginData.isShowAlert.toggle()
                                }
                            }
                        }
                        else {
                            loginData.signIn(email: self.loginData.email, password: self.loginData.password) { result in
                                switch result {
                                case.success(_):
                                    loginData.isMainPageShow.toggle()
                                case.failure(let error):
                                    loginData.alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                                    self.loginData.isShowAlert.toggle()
                                }
                            }
                        }
                    } label: {
                        Text(loginData.registerUser ? "Создать аккаунт" : "Войти")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Gold"))
                            .cornerRadius(15)
                    }
                    .padding(.top, 60)
                    .padding(.horizontal)
                    
                    Button {
                        withAnimation {
                            loginData.registerUser.toggle()
                        }
                        
                    } label: {
                        Text(loginData.registerUser ? "Уже есть аккаунт" : "Создать аккаунт")
                            .font(.custom(customFont, size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                    }
                    .padding(.top, 8)
                }
                .padding(30)
                .padding(.top, -20)
                .alert(loginData.alertMessage, isPresented: $loginData.isShowAlert) {
                    Button {} label: {
                        Text("Ok")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BGcolor"))
            .padding(.top, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BGcolor"))
        .fullScreenCover(isPresented: $loginData.isMainPageShow) {
            ContentView()
        }
    }
}

@ViewBuilder
func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
    
    VStack(alignment: .leading, spacing: 12) {
        
        Label {
            Text(title)
                .font(.custom(customFont, size: 16))
        } icon: {
            Image(systemName: icon)
        }
        .foregroundColor(Color.black)
        
        if title.contains("ароль") && !showPassword.wrappedValue{
            SecureField(hint, text: value)
                .padding(.top, 5)
        }
        else {
            TextField(hint, text: value)
                .padding(.top, 5)
        }
        
        Divider()
            .background(Color.black.opacity(0.8))
    }
    .overlay(
        
        Group {
            if title.contains("ароль") {
                Button(action: {
                    showPassword.wrappedValue.toggle()
                }, label: {
                    Text(showPassword.wrappedValue ? "Скрыть" : "Показать")
                        .font(.custom(customFont, size: 14).bold())
                        .foregroundColor(Color.black)
                })
                    .offset(y: 8)
            }
        }
        ,alignment: .trailing
    )
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
