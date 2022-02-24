//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @EnvironmentObject var stateManager: StateManager
    
    @ObservedObject var user: UserModel
    
    @State private var showPopUpWindow = false
    @State private var errorMessage = ""
    
    
    init(userUid: String) {
        user = UserModel(uid: userUid)
        
        UITableView.appearance().backgroundColor = .clear
        
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                HStack {
                    if let profilePicture = user.profilePicture {
                        Image(uiImage: profilePicture)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(40)
                            .overlay(Circle()
                                        .stroke(Color.black, lineWidth: 2)
                                        .frame(width: 80, height: 80))
                        
                    }
                    else {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
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
                    }
                    .padding(.bottom, 5)
                    
                    List(user.friends) { friend in
                        if friend.uid == stateManager.loggedUser.uid {
                            NavigationLink(destination: LoggedUserProfileView()) {
                                HStack {
                                    Button {
                                    } label: {
                                        HStack {
                                            if let profilePicture = friend.profilePicture {
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
                                            
                                            Text(friend.name)
                                                .font(.system(size: 20))
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                        else {
                            NavigationLink(destination: ProfileView(userUid: friend.uid)) {
                                HStack {
                                    Button {
                                    } label: {
                                        HStack {
                                            if let profilePicture = friend.profilePicture {
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
                                            
                                            Text(friend.name)
                                                .font(.system(size: 20))
                                        }
                                    }
                                    Spacer()
                                }
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
                
                if stateManager.loggedUser.hasFriend(friendUid: user.uid) {
                    Button {
                        removeFriend() { isRemoved in
                            if isRemoved {
                                user.updateView()
                            }
                            else {
                                showPopUpWindow = true
                                errorMessage = "There was an error. Try again later."
                            }
                        }
                    } label: {
                        Text("Remove friend")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("darkRed"))
                            .cornerRadius(40)
                            .overlay(RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color("darkRed"), lineWidth: 2)
                        )
                    }
                }
                else {
                    Button {
                        addFriend() { isAdded in
                            if isAdded {
                                user.updateView()
                            }
                            else {
                                showPopUpWindow = true
                                errorMessage = "There was an error. Try again later."
                            }
                        }
                    } label: {
                        Text("Add friend")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("darkGreen"))
                            .cornerRadius(40)
                            .overlay(RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color("darkGreen"), lineWidth: 2)
                        )
                    }
                }
                
                Spacer()
            }
            .blur(radius: showPopUpWindow ? 3 : 0)
        
            PopUpWindow(title: "Error", message: errorMessage, buttonText: "Okay", show: $showPopUpWindow)
                .alignmentGuide(.top) {
                    $0[VerticalAlignment.center]
                }
                .ignoresSafeArea()
            
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    private func removeFriend(response: @escaping (_ isRemoved: Bool) -> Void) {
        if stateManager.loggedUser.uid == "" {
            print("logged user uid is nil")
            response(false)
            return
        }
        
        if stateManager.loggedUser.friends.count == 0 {
            print("logged user has no friends")
            response(false)
            return
        }
        
        var friendIndex = -1
        var lastFriend = stateManager.loggedUser.friends[0]
        
        for friend in stateManager.loggedUser.friends {
            if friend.uid == user.uid {
                friendIndex = friend.index
            }
            if friend.index > lastFriend.index {
                lastFriend = friend
            }
        }
        
        if friendIndex == -1 {
            print("friend index is -1")
            response(false)
            return
        }
        
        let friendsDocument = FirebaseManager.instance.firestore.collection("friends").document(stateManager.loggedUser.uid)
        
        friendsDocument.updateData(["count": stateManager.loggedUser.friends.count - 1]) { error in
            if error != nil {
                print("error count")
                response(false)
                return
            }
        }
        
        if friendIndex != lastFriend.index {
            friendsDocument.updateData(["#\(friendIndex)": lastFriend.uid]) { error in
                if error != nil {
                    print("error swap friends")
                    response(false)
                    return
                }
            }
        }
        
        friendsDocument.updateData(["#\(lastFriend.index)": FieldValue.delete()]) { error in
            if error != nil {
                print("error delete last friend")
                response(false)
                return
            }
        }
        
        lastFriend.index = friendIndex
        
        stateManager.loggedUser.friends.remove(at: stateManager.loggedUser.friends.count - 1)
        
        response(true)
    }
    
    private func addFriend(response: @escaping (_ isAdded: Bool) -> Void) {
        if stateManager.loggedUser.uid == "" {
            print("logged user uid is nil")
            response(false)
            return
        }
        
        let friend = UserShortModel(uid: user.uid, index: stateManager.loggedUser.friends.count)
        stateManager.loggedUser.friends.append(friend)
        
        let friendsDocument = FirebaseManager.instance.firestore.collection("friends").document(stateManager.loggedUser.uid)
        
        friendsDocument.updateData(["count": stateManager.loggedUser.friends.count]) { error in
            if error != nil {
                print("error count")
                response(false)
                return
            }
        }
        
        friendsDocument.updateData(["#\(friend.index)": user.uid]) { error in
            if error != nil {
                print("error add friend")
                response(false)
                return
            }
        }
        
        response(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userUid: "")
            .environmentObject(StateManager())
    }
}
