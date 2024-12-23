import SwiftUI
import Charts

struct ChartsSection: View {
    let logEntries: [LogEntry]
    let tasteLogs: [TasteLog]
    @State private var selectedMetric: Metric = .ph
    
    private enum Metric {
        case ph
        case temperature
        
        var title: String {
            switch self {
            case .ph: return "pH History"
            case .temperature: return "Temperature History"
            }
        }
    }
    
    private var phEntries: [LogEntry] {
        logEntries.filter { $0.type == .ph }
    }
    
    private var tempEntries: [LogEntry] {
        logEntries.filter { $0.type == .temperature }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // pH/Temperature Chart Section
            chartCard {
                VStack {
                    Picker("Metric", selection: $selectedMetric) {
                        Text("pH").tag(Metric.ph)
                        Text("Temperature").tag(Metric.temperature)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    if selectedMetric == .ph {
                        LogHistoryChart(entries: phEntries, type: .ph)
                            .frame(height: 200)
                    } else {
                        LogHistoryChart(entries: tempEntries, type: .temperature)
                            .frame(height: 200)
                    }
                }
            }
            
            // Sweetness Chart
            chartCard("Sweetness") {
                TasteMetricChart(
                    logs: tasteLogs,
                    metricName: "Sweetness",
                    getValue: { $0.sweetness },
                    color: .blue
                )
                .frame(height: 200)
            }
            
            // Tartness Chart
            chartCard("Tartness") {
                TasteMetricChart(
                    logs: tasteLogs,
                    metricName: "Tartness",
                    getValue: { $0.tartness },
                    color: .orange
                )
                .frame(height: 200)
            }
            
            // Carbonation Chart (if 2F logs exist)
            if tasteLogs.contains(where: { $0.carbonation != nil }) {
                chartCard("Carbonation") {
                    TasteMetricChart(
                        logs: tasteLogs.filter { $0.carbonation != nil },
                        metricName: "Carbonation",
                        getValue: { $0.carbonation ?? 0 },
                        color: .purple
                    )
                    .frame(height: 200)
                }
            }
            
            // Flavor Strength Chart (if 2F logs exist)
            if tasteLogs.contains(where: { $0.flavorStrength != nil }) {
                chartCard("Flavor Strength") {
                    TasteMetricChart(
                        logs: tasteLogs.filter { $0.flavorStrength != nil },
                        metricName: "Flavor",
                        getValue: { $0.flavorStrength ?? 0 },
                        color: .green
                    )
                    .frame(height: 200)
                }
            }
            
            // Individual Taste Logs
            if !tasteLogs.isEmpty {
                chartCard("Detailed Taste Logs") {
                    ForEach(tasteLogs.sorted(by: { $0.timestamp > $1.timestamp })) { log in
                        TasteLogRow(log: log)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func chartCard<Content: View>(_ title: String? = nil, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            content()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 2)
        )
    }
}

#Preview {
    ChartsSection(
        logEntries: [],
        tasteLogs: []
    )
} 
