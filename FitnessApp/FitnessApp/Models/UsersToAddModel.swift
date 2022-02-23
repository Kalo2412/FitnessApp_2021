//
//  UsersToAddModel.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 2/23/22.
//

import SwiftUI

class UsersToAddModel: ObservableObject {
    @Published var users: [UserShortModel] = []
    
    init() {
        self.getAllUsers()
    }
    
    public func getAllUsers() {
        self.users = []
        
        FirebaseManager.instance.firestore.collection("users").getDocuments() { snapshot, error in
            if error != nil {
                return
            }
            
            for document in snapshot!.documents {
                self.users.append(UserShortModel(uid: document.documentID, index: -1))
            }
        }
    }
}
