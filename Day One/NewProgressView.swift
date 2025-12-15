//
//  NewProgressView.swift
//  Day One
//
//  Created by Aaron Thomas on 12/8/25.
//

import SwiftUI

struct NewProgressView: View {
    @State var displayedMonth: Date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date())) ?? Date()
    
    let calendar = Calendar.current
    
    @State var currentVisibleMonth: Date = Date()
    
    var body: some View {
        //ZStack
        VStack (alignment: .leading, spacing: 14){
            
            Text(monthTitle(for: currentVisibleMonth, full: true))
                .font(.title.bold())
                .contentTransition(.numericText())
            
            WeekdayHeaderView()
            
            ScrollViewReader { proxy in
                ScrollView{
                    VStack(spacing: 20) {
                        ForEach(generateMonths(), id: \.self){ month in
                            VStack(alignment: .leading,spacing: 3) {
                            Text(monthTitle(for: month))
                                .bold()
                                .padding(.bottom)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7), spacing: 2){
                                ForEach(generateMonthGrid(for: month), id: \.self) { date in
                                    let isCurrentMonth = calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month)
                                    Text("\(calendar.component(.day, from: date))")
                                        .font(.system(size: 15))
                                        .frame(maxWidth: .infinity, minHeight: 45)
                                        .foregroundStyle(isCurrentMonth ? Color.primary : .gray)
                                        .background(isCurrentMonth ? .BG : .gray.opacity(0.2), in: .rect(cornerRadius: 8))
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(lineWidth: 1)
                                                .foregroundStyle(calendar.isDateInToday(date) ? Color.primary : .clear)
                                        }
                                    
                                }
                            }
                            Spacer()
                        }
                        .id(month)
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .global).maxY){maxY,_ in
                                        let screenHeight = UIScreen.main.bounds.height
                                        if abs(maxY - screenHeight/1.8) < 44{
                                            withAnimation {
                                                currentVisibleMonth = month
                                            }
                                        }
                                    }
                            }
                        )
                        }
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { proxy.scrollTo(displayedMonth, anchor: .top) }
                    }
                }
            }
            .safeAreaPadding(.top,10 )
        }
        .padding(.horizontal, 10)
    }
    
    
    
    
    
    
    
    
    
    func monthTitle(for date: Date, full: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = full ? "MMMM" : "MMM"
        return formatter.string(from: date)
    }
    func generateMonths() -> [Date] {
        var months: [Date] = []
        let currentYear = calendar.component(.year, from: Date())
        for month in 1...12 {
            if let date = calendar.date(from: DateComponents(year: currentYear, month: month)){
                months.append(date)
            }
        }
        return months
    }
    
    func generateMonthGrid(for month: Date) -> [Date]{
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else{ return []}
        return stride(from: monthInterval.start, to: monthInterval.end, by: 86400).map{$0}
    }
}

#Preview {
    ProgressView()
}
