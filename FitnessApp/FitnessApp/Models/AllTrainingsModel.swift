//
//  AllTrainingsModel.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 2/25/22.
//

import FirebaseFirestore
import SwiftUI

class AllTrainingsModel: ObservableObject {
    @Published var trainings: [TrainingModel] = []
    
    init() {
        guard let currentUserUid = FirebaseManager.instance.auth.currentUser?.uid else {
            return
        }
        
        self.getAllTrainings(userUid: currentUserUid, userName: "")
        
        FirebaseManager.instance.firestore.collection("friends").document(currentUserUid).getDocument { document, error in
            guard error == nil else {
                return
            }
            
            let data = document?.data()
            if let data = data {
                let friendsCount = data["count"] as? Int ?? 0
                if friendsCount > 0 {
                    for friendIndex in 0 ... friendsCount - 1  {
                        let friendUid = data["#\(friendIndex)"] as? String ?? ""
                        
                        var friendName: String = "friend"
                        FirebaseManager.instance.firestore.collection("users").document(friendUid).getDocument { friendDocument, error in
                            guard error == nil else {
                                return
                            }
                            
                            guard let friendData = friendDocument?.data() else {
                                return
                            }
                            
                            friendName = friendData["name"] as? String ?? "friend"
                        }
                        
                        self.getAllTrainings(userUid: friendUid, userName: friendName)
                    }
                }
            }
        }
    }
    
    public func getAllTrainings(userUid: String, userName: String) {
        FirebaseManager.instance.firestore.collection("users").document(userUid).collection("trainings").getDocuments() { snapshot, error in
            if error != nil {
                return
            }
            
            for document in snapshot!.documents {
                let id = document.documentID
                
                let data = document.data()
                
                let title = data["title"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let time = (data["time"] as? Timestamp)?.dateValue() ?? Date()
                
                self.trainings.append(TrainingModel(id: id, title: title, description: description, time: time, userName: userName))
            }
        }
    }
}
