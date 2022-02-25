//
//  TrainingsListView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct TrainingsListView: View {
    @ObservedObject var allTrainings = AllTrainingsModel()
    
    var body: some View {
        List {
            Section(header: Text("My Trainings").font(.title).foregroundColor(Color("darkGreen")),
                    footer: Text("No more trainings").font(.title3).fontWeight(.ultraLight)) {
                ForEach(allTrainings.trainings) {  currentTraining in
                    TrainingsListRow(training: currentTraining)
                        .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct TrainingsListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsListView()
            .environmentObject(StateManager())
    }
}
