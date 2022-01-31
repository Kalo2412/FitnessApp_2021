//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by Sysprobs on 1/18/22.
//

import SwiftUI

@main
struct FitnessAppApp: App {
    @StateObject var stateManager = StateManager()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(stateManager)
                .onAppear(perform: {
                    print("TEST: \(stateManager.rootViewIsShownWhenLogOutForRegister)")
                })
        }
    }
}
