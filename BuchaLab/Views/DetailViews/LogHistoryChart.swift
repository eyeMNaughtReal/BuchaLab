import SwiftUI
import Charts

struct LogHistoryChart: View {
    let entries: [LogEntry]
    let type: LogEntry.LogType
    
    var body: some View {
        Chart {
            ForEach(entries.sorted(by: { $0.timestamp < $1.timestamp }), id: \.timestamp) { entry in
                LineMark(
                    x: .value("Time", entry.timestamp),
                    y: .value(type == .ph ? "pH" : "Temperature", entry.value)
                )
                .foregroundStyle(type == .ph ? Color.buchaLabTheme.primary : .blue)
                
                PointMark(
                    x: .value("Time", entry.timestamp),
                    y: .value(type == .ph ? "pH" : "Temperature", entry.value)
                )
                .foregroundStyle(type == .ph ? Color.buchaLabTheme.primary : .blue)
            }
        }
        .chartYScale(domain: type == .ph ? 2.5...7.0 : 60...85)
        .chartXAxis {
            AxisMarks(values: .automatic) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.month().day())
            }
        }
        .frame(height: 200)
        .padding()
    }
} 