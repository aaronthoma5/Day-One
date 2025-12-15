//
//  WeekdayHeaderView.swift
//  Day One
//
//  Created by Aaron Thomas on 12/8/25.
//

import SwiftUI

struct WeekdayHeaderView: View{
    let calendar = Calendar.current
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMMM yyyy"
        return f
    }()
    
    var weekdays: [String]{
        let symbols = calendar.shortStandaloneWeekdaySymbols
        return Array(symbols[1...6] + [symbols[0]])
    }
    
    var todayWeekdayIndex: Int {
        let originalIndex = calendar.component(.weekday, from: Date())-1
        return (originalIndex + 6) % 7
    }
    
    var body: some View{
        HStack(spacing:2){
            ForEach(weekdays.indices, id: \.self){index in
                Text(weekdays[index])
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(index == todayWeekdayIndex ? .primary: .gray)
                    .padding(.vertical, 3)
                    .background(index == todayWeekdayIndex ? .gray.opacity(0.4) : .gray.opacity(0.2), in: .rect(cornerRadius: 8))
            }
        }
    }
}
