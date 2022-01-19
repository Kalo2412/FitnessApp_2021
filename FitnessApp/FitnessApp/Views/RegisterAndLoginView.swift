//
//  RegisterAndLoginView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/18/22.
//

import SwiftUI

struct RegisterAndLoginView: View {
    @State private var isLoginMode = true
    
    @State private var registerModel = RegisterViewModel()
    @State private var loginModel = LoginViewModel()
    
    @State private var loginErrorMessage = ""
    @State private var registerErrorMessage = ""
    
    @State private var isActiveForLogin = false
    @State private var isActiveForRegister = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    Text("Fitness App")
                        .bold()
                        .font(.title)
                        .foregroundColor(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255))
                    
                    Image("app-icon")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80, alignment: .center)
                        
                    Spacer()
                    
                    if isLoginMode {
                        Group {
                            TextField("Email", text: $loginModel.email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                                
                            SecureField("Password", text: $loginModel.password)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                        }
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
                        
                        Spacer()
                        
                        NavigationLink(destination: HomePageView(), isActive: $isActiveForLogin) {
                            Button (action: {
                                login() { isLoggedIn in
                                    self.isActiveForLogin = isLoggedIn
                                }
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Log in")
                                        .foregroundColor(Color.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255))
                                        .cornerRadius(14)
                                    Spacer()
                                }
                            }
                        }
                        
                        Button {
                            changeModeToRegister()
                        } label: {
                            VStack {
                                Text("Don't have an account?")
                                    .foregroundColor(Color.black)
                                
                                Text("Register")
                                    .foregroundColor(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255))
                            }
                        }
                        
                        Text(loginErrorMessage)
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                    }
                    else
                    {
                        Group {
                            TextField("Email", text: $registerModel.email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                            SecureField("Password", text: $registerModel.password)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                            TextField("Name", text: $registerModel.name)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                            TextField("Age", text: $registerModel.age)
                                .keyboardType(.numberPad)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                            TextField("Proffecion", text: $registerModel.profession)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                        }
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
                        
                        Spacer()
                        
                        NavigationLink(destination: HomePageView(), isActive: $isActiveForRegister) {
                            Button (action: {
                                register() { isRegistered in
                                    self.isActiveForRegister = isRegistered
                                }
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Register")
                                        .foregroundColor(Color.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255))
                                        .cornerRadius(14)
                                    Spacer()
                                }
                            }
                        }
                        
                        Button {
                            changeModeToLogin()
                        } label: {
                            VStack {
                                Text("Already have an account?")
                                    .foregroundColor(Color.black)
                                
                                Text("Log in")
                                    .foregroundColor(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255))
                            }
                        }
                        
                        Text(registerErrorMessage)
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .navigationBarHidden(true)
                .navigationBarTitle("")
            }
            .background(Color(red: 207 / 255, green: 222 / 255, blue: 203 / 255)
                            .ignoresSafeArea())
            //.navigationBarBackButtonHidden(true)
        }
    }
    
    private func login(response: @escaping (_ isLoggedIn: Bool) -> Void) {
        UserManager.loginUser(email: loginModel.email, password: loginModel.password) {
            isLoggedIn in
            if !isLoggedIn {
                loginErrorMessage = "Incorrect email or password"
                response(false)
            }
            else {
                response(true)
            }
        }
    }
    
    private func register(response: @escaping (_ isRegistered: Bool) -> Void){
        UserManager.registerUser(email: registerModel.email, password: registerModel.password) {
            isRegistered, errorMessage in
            if !isRegistered {
                registerErrorMessage = errorMessage
                response(false)
            }
            else {
                response(true)
            }
        }
    }
    
    private func changeModeToLogin() {
        isLoginMode = true
    }
    
    private func changeModeToRegister() {
        isLoginMode = false
    }
}

struct RegisterAndLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAndLoginView()
    }
}
