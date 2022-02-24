//
//  UserModel.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

class UserModel: ObservableObject {
    @Published var uid: String = FirebaseManager.instance.auth.currentUser?.uid ?? ""
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var profession: String = ""
    @Published var friends: [UserShortModel] = []
    @Published var profilePicture: UIImage? = nil
    
    @Published var updater = false
    
    init(uid: String) {
        
        if uid != "" {
            let userDocument = FirebaseManager.instance.firestore.collection("users").document(uid)
            
            userDocument.getDocument { document, error in
                guard error == nil else {
                    return
                }
                
                let data = document?.data()
                if let data = data {
                    self.uid = uid
                    self.email = data["email"] as? String ?? ""
                    self.name = data["name"] as? String ?? ""
                    self.age = String(data["age"] as? Int ?? 0)
                    self.profession = data["profession"] as? String ?? ""
                }
                
                let friendsDocument = FirebaseManager.instance.firestore.collection("friends").document(uid)
                
                friendsDocument.getDocument { document, error in
                    guard error == nil else {
                        return
                    }
                    
                    let data = document?.data()
                    if let data = data {
                        let friendsCount = data["count"] as? Int ?? 0
                        if friendsCount > 0 {
                            for friendIndex in 0 ... friendsCount - 1  {
                                let friendUid = data["#\(friendIndex)"] as? String ?? ""
                                self.friends.append(UserShortModel(uid: friendUid, index: friendIndex))
                            }
                        }
                    }
                }
            }
            
            let ref = FirebaseManager.instance.storage.reference(withPath: uid)
            
            let maxSize: Int64 = 10 * 1024 * 1024 // 10MB
            ref.getData(maxSize: maxSize) { data, error in
                if  error != nil {
                    return
                }
                
                self.profilePicture = data.flatMap(UIImage.init)
            }
        }
    }
    
    public func hasFriend (friendUid: String) -> Bool {
        for friend in self.friends {
            if friend.uid == friendUid {
                return true
            }
        }
        
        return false
    }
    
    public func updateView() {
        updater.toggle()
        print("view should update")
    }
}
