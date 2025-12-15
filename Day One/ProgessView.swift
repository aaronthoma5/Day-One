//
//  ProgessView.swift
//  Day One
//
//  Created by Aaron Thomas on 12/7/25.
//
import SwiftUI

struct ProgressViewPage: View {
    @State private var selectedTab = 1 // default to Progress tab
 
//    
//    private var segmentedHeader: some View {
//       
//        Picker("", selection: $selectedTab) {
//            Text("Artwork").tag(0)
//            Text("Progress").tag(1)
//        }
//        .pickerStyle(.segmented)
//        .frame(width: 300)
//    }
//    
    
    @State private var months: [MonthData] = []
    @State private var selectedDay: DayData? = nil
    @State private var showingImagePicker = false
    
    init() {
        let calendar = Calendar.current
        let now = Date()
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: now) ?? now
        
        _months = State(initialValue: [
            generateMonthData(for: now),
            generateMonthData(for: previousMonth)
        ])
    }
    
    var body: some View {
        VStack(spacing: 16) {
//            segmentedHeader
            
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    ForEach(months.indices, id: \.self) { index in
                        MonthSection(month: $months[index], selectedDay: $selectedDay, showingImagePicker: $showingImagePicker)
                    }
                }
                .padding()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showingImagePicker) {
            ImagePickerView { image in
                if let image = image {
                    updateSelectedDayImage(image)
                }
            }
        }
    }
    
    
    private func updateSelectedDayImage(_ image: UIImage) {
        guard let selected = selectedDay else { return }
        
        guard let monthIndex = months.firstIndex(where: {
            $0.days.contains(where: { $0.id == selected.id })
        }) else { return }
        
        guard let dayIndex = months[monthIndex].days.firstIndex(where: {
            $0.id == selected.id
        }) else { return }
        
        months[monthIndex].days[dayIndex].image = image
    }
    
    
    func applyImageData(_ data: Data) {
        if let uiImage = UIImage(data: data) {
            updateSelectedDayImage(uiImage)
        }
    }
    
    
    struct MonthSection: View {
        @Binding var month: MonthData
        @Binding var selectedDay: DayData?
        @Binding var showingImagePicker: Bool
        
        let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text(month.name)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach($month.days) { $day in
                        DayCell(day: day)
                            .onTapGesture {
                                selectedDay = day
                                showingImagePicker = true
                            }
                    }
                }
            }
        }
    }
    
    
    struct DayCell: View {
        var day: DayData
        
        var body: some View {
            ZStack {
                if let image = day.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                } else {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(day.completed ? Color.gray.opacity(0.6)
                                            : Color.gray.opacity(0.6))
                }
            }
            .frame(height: 40)
        }
    }
    
    
    struct MonthData: Identifiable {
        let id = UUID()
        var name: String
        var days: [DayData]
    }
    
    struct DayData: Identifiable {
        let id = UUID()
        var completed: Bool
        var image: UIImage? = nil
    }
    
    
    func generateMonthData(for date: Date) -> MonthData {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date) ?? 1..<2
        
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        
        let monthName = formatter.string(from: date)
        let days = range.map { _ in DayData(completed: Bool.random()) }
        
        return MonthData(name: monthName, days: days)
    }
    
    
    struct ImagePickerView: UIViewControllerRepresentable {
        var onSelect: (UIImage?) -> Void
        
        func makeCoordinator() -> Coordinator {
            Coordinator(onSelect: onSelect)
        }
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            let onSelect: (UIImage?) -> Void
            
            init(onSelect: @escaping (UIImage?) -> Void) {
                self.onSelect = onSelect
            }
            
            func imagePickerController(
                _ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
            ) {
                let image = info[.originalImage] as? UIImage
                onSelect(image)
                picker.dismiss(animated: true)
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                onSelect(nil)
                picker.dismiss(animated: true)
            }
        }
    }
}

struct ProgressViewPage_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewPage()
    }
}
