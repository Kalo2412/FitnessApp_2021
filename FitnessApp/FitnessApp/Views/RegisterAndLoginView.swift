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
            ZStack {
                Image("startImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 5)
                
                ScrollView {
                    VStack(spacing: 15) {
                        Text("Fitness App")
                            .font(.system(size: 40, weight: .bold, design: .monospaced))
                            .foregroundColor(Color.white)
                        
                        Image("app-icon-white")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            
                        Spacer()
                        
                        if isLoginMode {
                            Group {
                                TextField("", text: $loginModel.email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .modifier(PlaceholderStyle(showPlaceHolder: loginModel.email.isEmpty, placeholder: "Email"))
                                
                                SecureField("", text: $loginModel.password)
                                    .modifier(PlaceholderStyle(showPlaceHolder: loginModel.password.isEmpty, placeholder: "Password"))
                            }
                            .frame(width: 250)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.white, lineWidth: 2)
                            )
                            
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
                                            .foregroundColor(Color.black)
                                            .bold()
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(Color.white)
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
                                        .foregroundColor(Color.white)
                                    
                                    Text("Register")
                                        .foregroundColor(Color.white)
                                        .bold()
                                }
                            }
                            
                            Text(loginErrorMessage)
                                .foregroundColor(Color.red)
                                .multilineTextAlignment(.center)
                        }
                        else
                        {
                            Group {
                                TextField("", text: $registerModel.email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .modifier(PlaceholderStyle(showPlaceHolder: registerModel.email.isEmpty, placeholder: "Email"))
                                
                                SecureField("", text: $registerModel.password)
                                    .modifier(PlaceholderStyle(showPlaceHolder: registerModel.password.isEmpty, placeholder: "Password"))
                                
                                TextField("", text: $registerModel.name)
                                    .modifier(PlaceholderStyle(showPlaceHolder: registerModel.name.isEmpty, placeholder: "Name"))
                                
                                TextField("", text: $registerModel.age)
                                    .keyboardType(.numberPad)
                                    .modifier(PlaceholderStyle(showPlaceHolder: registerModel.age.isEmpty, placeholder: "Age"))
                                
                                TextField("", text: $registerModel.profession)
                                    .modifier(PlaceholderStyle(showPlaceHolder: registerModel.profession.isEmpty, placeholder: "Proffecion"))
                                
                            }
                            .frame(width: 250)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.white, lineWidth: 2)
                            )
                            
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
                                            .foregroundColor(Color.black)
                                            .bold()
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(Color.white)
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
                                        .foregroundColor(Color.white)
                                    
                                    Text("Log in")
                                        .foregroundColor(Color.white)
                                        .bold()
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
            }
            .background(Color("lightGreen")
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

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(Color.white)
            }
            content
                .foregroundColor(Color.white)
        }
    }
}
