//
//  AddFriendView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 2/23/22.
//

import SwiftUI

struct AddFriendView: View {
    @EnvironmentObject var stateManager: StateManager
    
    @ObservedObject var usersToAdd: UsersToAddModel = UsersToAddModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Add friend")
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundColor(Color("darkGreen"))
                    .padding()
                
                List(usersToAdd.users.filter({ isPossibleFriend(friendUid: $0.uid) })) { user in
                    NavigationLink(destination: ProfileView(userUid: user.uid)) {
                        HStack {
                            Button {
                            } label: {
                                HStack {
                                    if let profilePicture = user.profilePicture {
                                        Image(uiImage: profilePicture)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                            .cornerRadius(15)
                                            .overlay(Circle()
                                                        .stroke(Color.black, lineWidth: 1)
                                                        .frame(width: 30, height: 30))
                                        
                                    }
                                    else {
                                        Image(systemName: "person.crop.circle")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                    }
                                        
                                    Text(user.name)
                                        .font(.system(size: 20))
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .listStyle(InsetListStyle())
                
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    private func isPossibleFriend(friendUid: String) -> Bool {
        return friendUid != stateManager.loggedUser.uid && !stateManager.loggedUser.hasFriend(friendUid: friendUid)
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
            .environmentObject(StateManager())
    }
}
