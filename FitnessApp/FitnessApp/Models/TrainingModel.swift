//
//  TrainingModel.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 2/25/22.
//

import SwiftUI

class TrainingModel: Identifiable, ObservableObject {
    @Published var id: String
    @Published var title: String
    @Published var description: String
    @Published var time: Date
    @Published var userName: String
    
    init(id: String, title: String, description: String, time: Date, userName: String) {
        self.id = id
        self.title = title
        self.description = description
        self.time = time
        self.userName = userName
    }
}
