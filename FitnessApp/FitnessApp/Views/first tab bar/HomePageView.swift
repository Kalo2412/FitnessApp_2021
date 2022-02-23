//
//  HomePageView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/19/22.
//

import SwiftUI

struct HomePageView: View {
    @State var currentDate: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                TrainingCalendar(currentDate: $currentDate)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(StateManager())
    }
}
