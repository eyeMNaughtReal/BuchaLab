import SwiftUI
import Charts

struct TasteChartView: View {
    let tasteLogs: [TasteLog]
    @State private var selectedLog: TasteLog?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView
            
            if tasteLogs.isEmpty {
                emptyStateView
            } else {
                chartView
            }
        }
    }
    
    private var headerView: some View {
        Text("Taste Profile")
            .font(.headline)
            .foregroundColor(Color.buchaLabTheme.primary)
    }
    
    private var emptyStateView: some View {
        Text("No taste logs recorded yet")
            .font(.subheadline)
            .foregroundColor(Color.buchaLabTheme.text)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }
    
    private var chartView: some View {
        Chart {
            ForEach(tasteLogs) { log in
                LineMark(
                    x: .value("Date", log.timestamp),
                    y: .value("Sweetness", log.sweetness)
                )
                .foregroundStyle(by: .value("Metric", "Sweetness"))
                
                LineMark(
                    x: .value("Date", log.timestamp),
                    y: .value("Tartness", log.tartness)
                )
                .foregroundStyle(by: .value("Metric", "Tartness"))
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    TasteChartView(tasteLogs: [
        TasteLog(
            timestamp: Date(),
            sweetness: 3,
            tartness: 4,
            comments: "Test log",
            phase: .firstFermentation,
            acidity: .balanced,
            readyForBottling: false,
            carbonation: nil,
            flavorStrength: nil,
            addedFlavor: nil,
            batchReady: nil,
            acidityNotes: nil,
            offNotes: nil,
            texture: nil,
            scobyReady: nil
        )
    ])
} 