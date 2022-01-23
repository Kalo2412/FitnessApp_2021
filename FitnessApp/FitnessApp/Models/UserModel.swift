//
//  UserModel.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

class UserModel {
    var uid: String = FirebaseManager.instance.auth.currentUser?.uid ?? ""
    var email: String = ""
    var name: String = ""
    var age: String = ""
    var profession: String = ""
    var friends: [FriendModel] = []
    var profilePicture: UIImage? = nil
    
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
                                self.friends.append(FriendModel(uid: friendUid))
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
}

class FriendModel: Identifiable {
    var uid: String = ""
    var name: String = ""
    var profilePicture: UIImage? = nil
    
    init(uid: String) {
        if uid != "" {
            FirebaseManager.instance.firestore.collection("users").document(uid).getDocument { document, error in
                guard error == nil else {
                    return
                }
                
                let data = document?.data()
                if let data = data {
                    self.uid = uid
                    self.name = data["name"] as? String ?? ""
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
}