//
//  DateValue.swift
//  FitnessApp
//
//  Created by Kaloyan Vachkov on 23.02.22.
//

import SwiftUI

struct DateValue : Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
