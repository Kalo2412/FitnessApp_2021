//
//  MainView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            TrainingsListView()
                .tabItem {
                    Label("Trainings", systemImage: "list.bullet")
                }
            
            ProfileView(userUid: FirebaseManager.instance.auth.currentUser?.uid as? String ?? "")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(Color("darkGreen"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
