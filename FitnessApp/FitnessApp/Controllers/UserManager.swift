//
//  UserManager.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/18/22.
//

import Firebase

class UserManager: NSObject {
    private let auth: Auth
    
    private static let instance = UserManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        
        super.init()
    }
    
    public static func registerUser(email: String, password: String, completionHandler: @escaping (_ isRegistered: Bool, _ errorMessage: String) -> Void) {
        instance.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completionHandler(false, error.localizedDescription.description)
            }
            else {
                completionHandler(true, "")
            }
        }
    }
    
    public static func loginUser(email: String, password: String, completionHandler: @escaping (_ isLoggedIn: Bool) -> Void) {
        instance.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completionHandler(false)
            }
            else {
                completionHandler(true)
            }
        }
    }
    
}
