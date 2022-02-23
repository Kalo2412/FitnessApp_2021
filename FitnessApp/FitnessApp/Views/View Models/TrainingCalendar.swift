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
                            .font(.title.bold())
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
                }
            }
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
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
