import SwiftUI
import Charts

struct TasteMetricChart: View {
    let logs: [TasteLog]
    let metricName: String
    let getValue: (TasteLog) -> Int
    let color: Color
    
    var body: some View {
        if logs.isEmpty {
            Text("No data recorded yet")
                .font(.subheadline)
                .foregroundColor(Color.buchaLabTheme.text)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
        } else {
            Chart {
                ForEach(logs) { log in
                    LineMark(
                        x: .value("Date", log.timestamp),
                        y: .value(metricName, getValue(log))
                    )
                    .foregroundStyle(color)
                    .interpolationMethod(.catmullRom)
                    
                    PointMark(
                        x: .value("Date", log.timestamp),
                        y: .value(metricName, getValue(log))
                    )
                    .foregroundStyle(color)
                }
            }
            .chartYScale(domain: 0...5)
            .chartXAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month().day())
                }
            }
            .frame(height: 200)
        }
    }
} 