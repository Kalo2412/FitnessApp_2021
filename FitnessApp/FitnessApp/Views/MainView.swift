//
//  MainView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        NavigationView {
            TabView(selection: $stateManager.selection) {
                HomePageView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(1)
                
                TrainingsListView()
                    .tabItem {
                        Label("Trainings", systemImage: "list.bullet")
                    }
                    .tag(2)
                
                ProfileView(userUid: FirebaseManager.instance.auth.currentUser?.uid ?? "")
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(3)
            }
            .navigationBarHidden(true)
            .accentColor(Color("darkGreen"))
        }
        .navigationBarHidden(true)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(StateManager())
    }
}
