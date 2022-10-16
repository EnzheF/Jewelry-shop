//
//  profile.swift
//  JewelryShop
//
//  Created by Энже Фатыхова on 14.05.2022.
//

import SwiftUI

struct profile: View {
    
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @StateObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack(spacing: 20) {
                        Button(action: {present.wrappedValue.dismiss()}) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Text("Профиль")
                        .font(.custom((customFont), size: 28))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(spacing: 15) {
                        
                        Image("person")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        TextField("Name", text: $viewModel.profile.name)
                            .font(.custom(customFont, size: 16).bold())
                        
                        HStack(alignment: .top, spacing: 10) {
                            Text("+7")
                                .font(.custom(customFont, size: 15))
                            TextField("phone", value: $viewModel.profile.phone, format: IntegerFormatStyle.number)
                                .font(.custom(customFont, size: 15))
                        }
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "location.north.circle")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            Text("Адрес: ")
                                .font(.custom(customFont, size: 15))
                            TextField("Your address", text: $viewModel.profile.adress)
                                .font(.custom(customFont, size: 15))
                        }
                        
                        HStack(alignment: .top, spacing: 10) {
                            Text("Ваша персональная скидка:    \(viewModel.discount()) %")
                                .font(.custom(customFont, size: 16).bold())
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .background(Color.white.cornerRadius(12))
                    .padding()
                    .padding(.top, 35)
                    
                    VStack(spacing: 15) {
                        Text("Мои заказы: ")
                            .font(.custom((customFont), size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(viewModel.orders, id: \.id) { order in
                            OrderCell(order: order)
                                .padding(.bottom, 20)
                        }
                    }
                    
                    Button {
                        loginData.signOut()
                        loginData.registerUser.toggle()
                        //LoginPage()
                        present.wrappedValue.dismiss()
                    } label: {
                        Text("Выйти")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Gold"))
                            .cornerRadius(15)
                    }
                    .padding()
                    .padding(.top, 40)
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 25)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BGcolor")
                    .ignoresSafeArea())
        }
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear {
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }
    
    @ViewBuilder
    func OrderCell(order: Order) -> some View {
        HStack {
            Text("\(order.date)")
                //.frame(width: 230)
                .font(.custom((customFont), size: 15))
                .padding(5)
            
            Text("\(order.status)")
                //.frame(width: 100)
                .font(.custom((customFont), size: 15))
                .padding(5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.white))
        //.padding([.horizontal, .vertical])
        .cornerRadius(12)
        .padding([.horizontal, .top])
    }
    
}

struct profile_Previews: PreviewProvider {
    static var previews: some View {
        profile(viewModel: ProfileViewModel(profile: Users(id: "", name: "Элизабет Фиксон", phone: 9004762893, adress: "ул. Петербургская, д. 14")))
    }
}
