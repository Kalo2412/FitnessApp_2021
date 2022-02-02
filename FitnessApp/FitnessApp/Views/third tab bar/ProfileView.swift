//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var stateManager: StateManager
    @State var user: UserModel
    
    @State private var showPopUpWindow = false
    @State private var errorMessage = ""
    
    @State private var isActiveForSignOut = false
    
    @State private var showImagePicker = false
    @State private var image: UIImage = UIImage()
    
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
                        
                            Button {
                                showImagePicker = true
                            } label: {
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
                            
                            Spacer()
                            
                            VStack {
                                Button {
                                    if signOut() {
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
                        else {
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
            
        }
        .navigationBarHidden(user.uid == FirebaseManager.instance.auth.currentUser?.uid)
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
        guard let uid = FirebaseManager.instance.auth.currentUser?.uid else {
            response(false)
            return
        }
        
        let ref = FirebaseManager.instance.storage.reference(withPath: uid)
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
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
        
        user.profilePicture = image
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userUid: "")
            .environmentObject(StateManager())
    }
}
