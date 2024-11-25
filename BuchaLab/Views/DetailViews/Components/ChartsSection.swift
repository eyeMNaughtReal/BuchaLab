import SwiftUI
import Charts

struct ChartsSection: View {
    let logEntries: [LogEntry]
    let tasteLogs: [TasteLog]
    
    private var phEntries: [LogEntry] {
        logEntries.filter { $0.type == .ph }
    }
    
    private var tempEntries: [LogEntry] {
        logEntries.filter { $0.type == .temperature }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // pH Chart
            chartCard("pH History") {
                LogHistoryChart(entries: phEntries, type: .ph)
            }
            
            // Temperature Chart
            chartCard("Temperature History") {
                LogHistoryChart(entries: tempEntries, type: .temperature)
            }
            
            // Sweetness Chart
            chartCard("Sweetness") {
                TasteMetricChart(
                    logs: tasteLogs,
                    metricName: "Sweetness",
                    getValue: { $0.sweetness },
                    color: .blue
                )
            }
            
            // Tartness Chart
            chartCard("Tartness") {
                TasteMetricChart(
                    logs: tasteLogs,
                    metricName: "Tartness",
                    getValue: { $0.tartness },
                    color: .orange
                )
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
        .padding(.horizontal)
    }
    
    private func chartCard<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.buchaLabTheme.primary)
            content()
        }
        .padding()
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