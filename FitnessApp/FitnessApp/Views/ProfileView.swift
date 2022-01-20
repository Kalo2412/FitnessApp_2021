//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct ProfileView: View {
    @State var user: UserModel = UserModel(uid: FirebaseManager.instance.auth.currentUser?.uid ?? "")
    
    init(userUid: String) {
        user = UserModel(uid: userUid)
        
        //data for the preview this:
        /*user.name = "Ivan"
        user.email = "ivan@gmail.com"
        user.age = "25"
        user.profession = "Influencer"*/
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.crop.circle")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)

            Text(user.name)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundColor(Color.black)
            
            // TODO: logout button
            
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
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userUid: "")
    }
}
