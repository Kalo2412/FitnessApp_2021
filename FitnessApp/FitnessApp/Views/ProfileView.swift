//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct ProfileView: View {
    @State var user: UserModel = UserModel(uid: FirebaseManager.instance.auth.currentUser?.uid ?? "")
    
    @State private var showPopUpWindow = false
    
    @State private var isActiveForSignOut = false
    
    init(userUid: String) {
        user = UserModel(uid: userUid)
    }
    
    var body: some View {
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
                        
                        VStack {
                            NavigationLink(destination: StartView().navigationBarBackButtonHidden(true), isActive: $isActiveForSignOut) {
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
                        }
                        .frame(maxHeight: 80, alignment: .top)
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
                    
                    // TODO: display friends
                }
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color("darkGreen"), lineWidth: 2)
                )
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .blur(radius: showPopUpWindow ? 3 : 0)
        
            PopUpWindow(title: "Error", message: "There was an error. Try signing out later.", buttonText: "Okay", show: $showPopUpWindow)
                .alignmentGuide(.top) {
                    $0[VerticalAlignment.center]
                }
                .ignoresSafeArea()
            
        }
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
