//
//  stateManager.swift
//  FitnessApp
//
//  Created by Kaloyan Vachkov on 24.01.22.
//

import Foundation

class StateManager: ObservableObject {
    @Published var rootViewIsShownWhenLogOut: Bool = false
    @Published var rootViewIsShownWhenLogOutForRegister: Bool = false
    @Published var isLoginMode: Bool = true
    @Published var selection: Int = 1
    
}
