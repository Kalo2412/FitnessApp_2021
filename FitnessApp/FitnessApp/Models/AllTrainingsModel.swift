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
        self.getAllTrainings()
    }
    
    public func getAllTrainings() {
        self.trainings = []
        
        FirebaseManager.instance.firestore.collection("users").document(FirebaseManager.instance.auth.currentUser?.uid ?? "").collection("trainings").getDocuments() { snapshot, error in
            if error != nil {
                return
            }
            
            for document in snapshot!.documents {
                let id = document.documentID
                
                let data = document.data()
                
                let title = data["title"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let time = (data["time"] as? Timestamp)?.dateValue() ?? Date()
                
                self.trainings.append(TrainingModel(id: id, title: title, description: description, time: time))
            }
        }
    }
}
