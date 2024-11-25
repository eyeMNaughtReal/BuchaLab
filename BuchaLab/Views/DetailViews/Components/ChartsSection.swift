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
            VStack(alignment: .leading, spacing: 8) {
                Text("pH History")
                    .font(.headline)
                    .foregroundColor(Color.buchaLabTheme.primary)
                LogHistoryChart(entries: phEntries, type: .ph)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(radius: 2)
            )
            
            // Temperature Chart
            VStack(alignment: .leading, spacing: 8) {
                Text("Temperature History")
                    .font(.headline)
                    .foregroundColor(Color.buchaLabTheme.primary)
                LogHistoryChart(entries: tempEntries, type: .temperature)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(radius: 2)
            )
            
            // Taste History
            if !tasteLogs.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Taste History")
                        .font(.headline)
                        .foregroundColor(Color.buchaLabTheme.primary)
                    ForEach(tasteLogs.sorted(by: { $0.timestamp > $1.timestamp })) { log in
                        TasteLogRow(log: log)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ChartsSection(
        logEntries: [],
        tasteLogs: []
    )
} 