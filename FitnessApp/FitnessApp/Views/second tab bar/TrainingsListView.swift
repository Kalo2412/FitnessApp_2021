//
//  TrainingsListView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct TrainingsListView: View {
    var body: some View {
        Text("Trainings list..")
    }
}

struct TrainingsListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsListView()
            .environmentObject(StateManager())
    }
}
