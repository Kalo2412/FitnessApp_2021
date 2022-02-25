//
//  Training.swift
//  FitnessApp
//
//  Created by Kaloyan Vachkov on 23.02.22.
//

import SwiftUI

struct Training: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var time: Date = Date()
}

struct TrainingMetaData: Identifiable {
    var id = UUID().uuidString
    var training: [Training]
    var trainingDate: Date
}

// Mock trainings
/*func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var trainings: [TrainingMetaData] = [
    TrainingMetaData(training: [
                        Training(title: "Workout at home", description: "Pam's youtube video"),
                        Training(title: "Jogging 5 km", description: "")],
     trainingDate: getSampleDate(offset: 2)),
    TrainingMetaData(training: [
                        Training(title: "Gym weight training", description: "Leg day"),
                        Training(title: "Jogging 5 km", description: ""),
                        Training(title: "Streching", description: "For back pain")],
     trainingDate: getSampleDate(offset: -4)),
    TrainingMetaData(training: [
                        Training(title: "Playing football", description: ""),
                        Training(title: "Jogging 3 km", description: "Lake Pancharevo route")],
     trainingDate: getSampleDate(offset: 3)),
    TrainingMetaData(training: [
                        Training(title: "Yoga at home", description: ""),],
     trainingDate: getSampleDate(offset: -2))
]*/
