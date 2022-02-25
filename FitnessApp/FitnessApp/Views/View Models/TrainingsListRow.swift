//
//  TrainingsListRow.swift
//  FitnessApp
//
//  Created by Kaloyan Vachkov on 18.02.22.
//

import SwiftUI

struct TrainingsListRow: View {
    let training: TrainingModel
    
    var body: some View {
        ZStack {
            Color("skyGreen")
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(training.title)
                        .font(.headline)
                    Text(training.time.addingTimeInterval(Double.random(in: 0...5000)), style: .time)
                    Label(extractDate(),systemImage: "calendar")
                }
                Spacer()
                PopUpDescription(description: training.description)
            }
            .padding()
        }
    }
    
    func extractDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM YYYY"
        
        let date = formatter.string(from: training.time)
        
        return date
    }
}

struct PopUpDescription: View {
    let description: String
    
    init(description: String) {
        self.description = description
    }
    
    var body: some View {
        Menu {
            Text("Description:\n\(description)")
        } label: {
            Image(systemName: "questionmark.circle")
                .frame(width: 50, height: 50)
        }
    }
}

struct TrainingsListRow_Previews: PreviewProvider {
    static var testTraining = TrainingModel(id: "id", title: "Test training", description: "Some description here..", time: Date())
    static var previews: some View {
        TrainingsListRow(training: testTraining)
        //PopUpDescription()
            .previewLayout(.fixed(width: 400, height: 80))
    }
}


