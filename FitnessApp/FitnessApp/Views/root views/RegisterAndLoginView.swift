//
//  RegisterAndLoginView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/18/22.
//

import SwiftUI

struct RegisterAndLoginView: View {
    @EnvironmentObject var stateManager: StateManager
    
    @State private var registerModel = RegisterModel()
    @State private var loginModel = LoginModel()
    
    @State private var errorMessage = ""
    @State private var showPopUpWindow = false
    
    @State private var isActiveForLogin = false
    @State private var isActiveForRegister = false
    

    

    var body: some View {
        ZStack {
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
                            
                            if stateManager.isLoginMode {
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
                                
                                NavigationLink(destination: MainView().navigationBarBackButtonHidden(true), isActive: $isActiveForLogin) {
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
                                
                                VStack {
                                    Text("Don't have an account?")
                                        .foregroundColor(Color.white)
                                    
                                    Button {
                                        stateManager.isLoginMode = false
                                    } label: {
                                            Text("Register")
                                                .foregroundColor(Color.white)
                                                .bold()
                                    }
                                }
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
                                
                                NavigationLink(destination: MainView().navigationBarBackButtonHidden(true), isActive: $isActiveForRegister) {
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
                                
                                VStack {
                                    Text("Already have an account?")
                                        .foregroundColor(Color.white)
                                    
                                    Button {
                                        stateManager.isLoginMode = true
                                    } label: {
                                            Text("Log in")
                                                .foregroundColor(Color.white)
                                                .bold()
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                .background(Color("lightGreen")
                                .ignoresSafeArea())
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .blur(radius: showPopUpWindow ? 3 : 0)
        
            PopUpWindow(title: "Error", message: errorMessage, buttonText: "Okay", show: $showPopUpWindow)
                .alignmentGuide(.top) {
                    $0[VerticalAlignment.center]
                }
                .ignoresSafeArea()
        }
    }
    
    private func login(response: @escaping (_ isLoggedIn: Bool) -> Void) {
        FirebaseManager.instance.auth.signIn(withEmail: loginModel.email, password: loginModel.password) { result, error in
            if error != nil {
                showPopUpWindow = true
                errorMessage = "Incorrect email or password"
                response(false)
            }
            else {
                stateManager.loggedUser = UserModel(uid: FirebaseManager.instance.auth.currentUser?.uid ?? "")
                response(true)
            }
        }
    }
    
    private func register(response: @escaping (_ isRegistered: Bool) -> Void){
        if registerModel.name == "" {
            showPopUpWindow = true
            errorMessage = "Invalid name"
            response(false)
            return
        }
        
        let ageAsInt = Int(registerModel.age) ?? 0
        if ageAsInt <= 0 || ageAsInt > 100 {
            showPopUpWindow = true
            errorMessage = "Invalid age!"
            response(false)
            return
        }
        
        if registerModel.profession == "" {
            showPopUpWindow = true
            errorMessage = "Invalid proffession"
            response(false)
            return
        }
        
        FirebaseManager.instance.auth.createUser(withEmail: registerModel.email, password: registerModel.password) { result, error in
            if let error = error {
                showPopUpWindow = true
                errorMessage = error.localizedDescription.description
                response(false)
                return
            }
            
            guard let userUid = result?.user.uid else {
                errorMessage = "Server error - registration unsuccessful!"
                response(false)
                return
            }
            
            var isThereError = false
            
            FirebaseManager.instance.firestore.collection("users").document(userUid)
                .setData(["email": registerModel.email,
                          "name": registerModel.name,
                          "age": ageAsInt,
                          "proffession": registerModel.profession])
                { error in
                    if error != nil {
                        isThereError = true
                    }
                }
            
            if !isThereError {
                FirebaseManager.instance.firestore.collection("friends").document(userUid)
                    .setData(["count": 0])
                    { error in
                        if error != nil {
                            isThereError = true
                        }
                    }
            }
            
            if isThereError {
                FirebaseManager.instance.auth.currentUser?.delete()
                showPopUpWindow = true
                errorMessage = "Server error - registration unsuccessful!"
                response(false)
                return
            }
            
            stateManager.loggedUser = UserModel(uid: FirebaseManager.instance.auth.currentUser?.uid ?? "")
            
            response(true)
        }
    }
    
    
}

struct RegisterAndLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAndLoginView()
            .environmentObject(StateManager())
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
