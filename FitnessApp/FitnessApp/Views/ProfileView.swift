//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct ProfileView: View {
    @State var user: UserModel
    
    @State private var showPopUpWindow = false
    
    @State private var isActiveForSignOut = false
    
    init(userUid: String) {
        _user = State(initialValue: UserModel(uid: userUid))
        
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 15) {
                    HStack {
                        if user.uid == FirebaseManager.instance.auth.currentUser?.uid {
                            Spacer()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Image(systemName: "person.crop.circle")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                        
                        if user.uid == FirebaseManager.instance.auth.currentUser?.uid {
                            Spacer()
                            
                            NavigationLink(destination: StartView().navigationBarBackButtonHidden(true), isActive: $isActiveForSignOut) {
                                VStack {
                                    Button {
                                        if signOut() {
                                            isActiveForSignOut = true
                                        }
                                        else {
                                            showPopUpWindow = true
                                        }
                                    } label: {
                                        Text("Sign out")
                                            .foregroundColor(Color("darkGreen"))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .frame(maxHeight: 80, alignment: .top)
                            }
                        }
                    }
                    .padding()

                    Text(user.name)
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.black)
                    
                    VStack {
                        HStack {
                            Text("Personal info")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Spacer()
                            
                            if user.uid == FirebaseManager.instance.auth.currentUser?.uid {
                                Button {
                                    // TODO: edit profile..
                                } label: {
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 20))
                                }
                                .accentColor(Color("darkGreen"))
                            }
                        }
                        .padding(.bottom, 5)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("name:")
                                Text("email:")
                                Text("age:")
                                Text("profession:")
                            }
                            
                            VStack(alignment: .leading) {
                                Text(user.name)
                                Text(user.email)
                                Text(user.age)
                                Text(user.profession)
                            }
                        }
                    }
                    .padding()
                    .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("darkGreen"), lineWidth: 2)
                    )
                    .padding()
                    
                    VStack {
                        HStack {
                            Text("Friends")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Spacer()
                            
                            if user.uid == FirebaseManager.instance.auth.currentUser?.uid {
                                Button {
                                    // TODO: add frined..
                                } label: {
                                    Image(systemName: "person.badge.plus")
                                        .font(.system(size: 20))
                                }
                                .accentColor(Color("darkGreen"))
                            }
                        }
                        .padding(.bottom, 5)
                        
                        List(user.friends) { friend in
                            NavigationLink(destination: ProfileView(userUid: friend.uid)) {
                                HStack {
                                    Button {
                                    } label: {
                                        HStack {
                                            Image(systemName: "person.crop.circle")
                                                .font(.system(size: 30))
                                                
                                            Text(friend.name)
                                                .font(.system(size: 20))
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .listStyle(InsetListStyle())
                    }
                    .padding()
                    .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("darkGreen"), lineWidth: 2)
                    )
                    .padding()
                    
                    Spacer()
                }
                .blur(radius: showPopUpWindow ? 3 : 0)
            
                PopUpWindow(title: "Error", message: "There was an error. Try signing out later.", buttonText: "Okay", show: $showPopUpWindow)
                    .alignmentGuide(.top) {
                        $0[VerticalAlignment.center]
                    }
                    .ignoresSafeArea()
                
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(user.uid == FirebaseManager.instance.auth.currentUser?.uid)
    }
    
    private func signOut() -> Bool {
        do {
            try FirebaseManager.instance.auth.signOut()
            return true
        }
        catch {
            return false
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userUid: "")
    }
}
