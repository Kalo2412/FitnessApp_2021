//
//  UserModel.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

class UserModel {
    var uid: String = FirebaseManager.instance.auth.currentUser?.uid ?? ""
    var email: String = ""
    var name: String = ""
    var age: String = ""
    var profession: String = ""
    
    init(uid: String) {
        
        if uid != "" {
            FirebaseManager.instance.firestore.collection("users").document(uid).getDocument { document, error in
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
            }
        }
    }
}
