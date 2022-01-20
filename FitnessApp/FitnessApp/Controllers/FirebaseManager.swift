//
//  FirebaseManager.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/18/22.
//

import Firebase
import FirebaseFirestore

class FirebaseManager: NSObject {
    public let auth: Auth
    public let firestore: Firestore
    
    public static let instance = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
