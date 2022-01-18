//
//  RegisterAndLoginView.swift
//  FitnessApp
//
//  Created by Sysprobs on 1/18/22.
//

import SwiftUI

struct RegisterAndLoginView: View {
    @State var isLoginMode = true
    
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var age = ""
    @State var profession = ""
    
    @State var loginErrorMessage = ""
    @State var registerErrorMessage = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 8) {
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
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                                
                            SecureField("Password", text: $password)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                        }
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
                        
                        Spacer()
                        
                        Button
                        {
                            login()
                        } label: {
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
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                            SecureField("Password", text: $password)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                            TextField("Name", text: $name)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                            TextField("Age", text: $age)
                                .keyboardType(.numberPad)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                            TextField("Proffecion", text: $profession)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 42 / 255, green: 104 / 255, blue: 115 / 255), lineWidth: 2)
                                )
                            
                        }
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
                        
                        Spacer()
                        
                        Button
                        {
                            register()
                        } label: {
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
            }
            .background(Color(red: 207 / 255, green: 222 / 255, blue: 203 / 255)
                            .ignoresSafeArea())
        }
    }
    
    private func login() {
        // TODO
    }
    
    private func register() {
        // TODO
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
