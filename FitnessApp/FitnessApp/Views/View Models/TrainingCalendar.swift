//
//  TrainingCalendar.swift
//  FitnessApp
//
//  Created by Kaloyan Vachkov on 23.02.22.
//

import SwiftUI

struct TrainingCalendar: View {
    @Binding var currentDate: Date
    
    @State var currentMonth: Int = 0
    var body: some View {
        VStack(spacing: 35) {
            
            let days: [String] = ["Sun","Mon", "Tue", "Wed","Thu", "Fri", "Sat"]
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color("skyGreen"))
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(extractDate()[0])
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                        Text(extractDate()[1])
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                        withAnimation {
                            currentMonth -= 1
                        }
                    }, label: {
                        Image(systemName: "lessthan")
                            .font(.system(size: 30))
                            .foregroundColor(Color("grassyGreen"))
                    })
                    Button(action: {
                        withAnimation {
                            currentMonth += 1
                        }
                    }, label: {
                        Image(systemName: "greaterthan")
                            .font(.system(size: 30))
                            .foregroundColor(Color("grassyGreen"))
                    })
                }
                .padding(.horizontal,25)
            }
                
            
            HStack(spacing: 0) {
                ForEach(days,id: \.self) { day in
                    if day == "Sun" || day == "Sat" {
                        Text(day)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("darkGreen"))
                    } else {
                        Text(day)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color("darkGreen"))
                                .padding(.horizontal,8)
                                .opacity(isSameDay(date1: value.date, date2:
                                  currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack(spacing: 15){
                
                VStack(spacing: 10) {
                    Text("Trainings")
                        .font(.title)
                        .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("My Trainings")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("grassyGreen"))
                }
                .padding(.leading, 5)
                .padding(.vertical, 10)
                
                if let training = trainings.first(where: { training in
                    return isSameDay(date1: training.trainingDate, date2: currentDate)
                }) {
                    ForEach(training.training) { training in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(training.time.addingTimeInterval(Double.random(in: 0...5000)), style: .time)
                            
                            Text(training.title)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            Color("skyGreen")
                                .opacity(0.5)
                                .cornerRadius(10)
                        )
                    }
                } else {
                    Text("Not trainings for today")
                }
                
                
            }
            .padding()
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if let training = trainings.first(where: { training in
                    return isSameDay(date1: training.trainingDate, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(isSameDay(date1: training.trainingDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: training.trainingDate, date2: currentDate) ? .white : Color("grassyGreen"))
                        .frame(width: 8, height: 8)
                    
                } else {
                    Text("\(value.day)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extractDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at:  0)
        }
        
        return days
    }
}

struct TrainingCalendar_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
