//
//  TrainingsListRow.swift
//  FitnessApp
//
//  Created by Kaloyan Vachkov on 18.02.22.
//

import SwiftUI

struct TrainingsListRow: View {
    let testTraining: Training
    var body: some View {
        ZStack {
            Color("skyGreen")
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(testTraining.title)
                        .font(.headline)
                    Text(testTraining.time.addingTimeInterval(Double.random(in: 0...5000)), style: .time)
                    Label(extractDate(),systemImage: "calendar")
                }
                Spacer()
                PopUpDescription()
            }
            .padding()
        }
    }
    
    func extractDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM YYYY"
        
        let date = formatter.string(from: testTraining.time)
        
        return date
    }
}

struct PopUpDescription: View {
    var body: some View {
        Menu {
            Button("Cancel") {
            }
            Text("Description:\nednjednewnoewenoned\ndjkskd")
        } label: {
            Image(systemName: "questionmark.circle")
                .frame(width: 50, height: 50)
        }
    }
}

struct TrainingsListRow_Previews: PreviewProvider {
    static var testTraining = trainings[0].training[0]
    static var previews: some View {
        TrainingsListRow(testTraining: testTraining)
        //PopUpDescription()
            .previewLayout(.fixed(width: 400, height: 80))
    }
}


