//
//  FriendModel.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 2/22/22.
//

import SwiftUI

class FriendModel: Identifiable {
    var index: Int = -1
    var uid: String = ""
    var name: String = ""
    var profilePicture: UIImage? = nil
    
    init(uid: String, index: Int) {
        self.index = index
        
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
