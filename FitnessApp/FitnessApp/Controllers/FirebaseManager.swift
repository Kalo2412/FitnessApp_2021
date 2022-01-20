//
//  FirebaseManager.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/18/22.
//

import Firebase

class FirebaseManager: NSObject {
    public let auth: Auth
    
    public static let instance = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        
        super.init()
    }
    
}
