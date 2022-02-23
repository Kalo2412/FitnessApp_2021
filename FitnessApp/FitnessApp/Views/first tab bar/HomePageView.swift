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
            .padding(.vertical)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .overlay(
            Button {
                //todo
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 80)
                    .background(Color("darkGreen").cornerRadius(50).opacity(0.5))
                    .padding()
            }, alignment: .bottomLeading
        )
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(StateManager())
    }
}
