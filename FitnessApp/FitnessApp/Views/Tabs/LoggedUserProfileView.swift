//
//  LoggedUserProfileView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 2/24/22.
//

import SwiftUI
import Firebase

struct LoggedUserProfileView: View {
    @EnvironmentObject var stateManager: StateManager
    
    @State private var showPopUpWindow = false
    @State private var errorMessage = ""
    
    @State var isActiveForAddFriend = false
    
    @State private var showImagePicker = false
    @State private var image: UIImage = UIImage()
    
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        showImagePicker = true
                    } label: {
                        if let profilePicture = stateManager.loggedUser.profilePicture {
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
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            if signOut() {
                                stateManager.isLoginMode = true
                                stateManager.rootViewIsShownWhenLogOut = false
                                stateManager.rootViewIsShownWhenLogOutForRegister = false
                                stateManager.selection = 1
                            }
                            else {
                                showPopUpWindow = true
                                errorMessage = "There was an error. Try signing out later."
                            }
                        } label: {
                            Text("Sign out")
                                .foregroundColor(Color("darkGreen"))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(maxHeight: 80, alignment: .top)
                    
                }
                .padding()

                Text(stateManager.loggedUser.name)
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.black)
                
                VStack {
                    HStack {
                        Text("Personal info")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            // TODO: edit profile..
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 20))
                        }
                        .accentColor(Color("darkGreen"))
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
                            Text(stateManager.loggedUser.name)
                            Text(stateManager.loggedUser.email)
                            Text(stateManager.loggedUser.age)
                            Text(stateManager.loggedUser.profession)
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
                        
                        NavigationLink(destination: AddFriendView(), isActive: $isActiveForAddFriend) {
                            Button {
                                isActiveForAddFriend = true
                            } label: {
                                Image(systemName: "person.badge.plus")
                                    .font(.system(size: 20))
                            }
                            .accentColor(Color("darkGreen"))
                        }
                    }
                    .padding(.bottom, 5)
                    
                    List(stateManager.loggedUser.friends) { friend in
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
        
            PopUpWindow(title: "Error", message: errorMessage, buttonText: "Okay", show: $showPopUpWindow)
                .alignmentGuide(.top) {
                    $0[VerticalAlignment.center]
                }
                .ignoresSafeArea()
            
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
            ImagePicker(sourceType: .photoLibrary, completionHandler: didSelectImage)
        }
    }
    
    func didSelectImage(_ image: UIImage?) {
        showImagePicker = false
        
        if let image = image {
            updateProfilePicture(image: image) { isUpdated in
                if !isUpdated {
                    showPopUpWindow = true
                    errorMessage = "There was an error. Profile picture cannot be saved."
                }
            }
        }
    }
    
    private func updateProfilePicture(image: UIImage, response: @escaping (_ isUpdated: Bool) -> Void) {
        let ref = FirebaseManager.instance.storage.reference(withPath: stateManager.loggedUser.uid)
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            response(false)
            return
        }
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if error != nil {
                response(false)
                return
            }
            
            ref.downloadURL { url, error in
                if error != nil {
                    response(false)
                    return
                }
                else {
                    
                }
            }
        }
        
        stateManager.loggedUser.profilePicture = image
        response(true)
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

struct LoggedUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userUid: "")
            .environmentObject(StateManager())
    }
}
