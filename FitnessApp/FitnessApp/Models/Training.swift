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
    var time: Date = Date()
}

struct TrainingMetaData: Identifiable {
    var id = UUID().uuidString
    var training: [Training]
    var trainingDate: Date
}

func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var trainings: [TrainingMetaData] = [
    TrainingMetaData(training: [
        Training(title: "Workout at home"),
        Training(title: "Jogging 5 km")],
     trainingDate: getSampleDate(offset: 2)),
    TrainingMetaData(training: [
        Training(title: "Gym weight training"),
        Training(title: "Jogging 5 km"),
        Training(title: "Streching")],
     trainingDate: getSampleDate(offset: -4)),
    TrainingMetaData(training: [
        Training(title: "Playing football"),
        Training(title: "Jogging 3 km")],
     trainingDate: getSampleDate(offset: 3)),
    TrainingMetaData(training: [
        Training(title: "Yoga at home"),],
     trainingDate: getSampleDate(offset: -2))
]
