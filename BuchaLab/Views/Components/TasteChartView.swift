import SwiftUI
import Charts

struct TasteChartView: View {
    let tasteLogs: [TasteLog]
    @State private var selectedLog: TasteLog?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            
            if tasteLogs.isEmpty {
                emptyStateView
            } else {
                chartView
            }
        }
        .chartYScale(domain: 0...5)
        .chartLegend(position: .bottom)
        .frame(height: 200)
    }
    
    private var headerView: some View {
        Text("Taste Profile")
            .font(.headline)
    }
    
    private var emptyStateView: some View {
        Text("No taste logs recorded yet")
            .font(.subheadline)
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
                .foregroundStyle(Color.blue)
                .interpolationMethod(.catmullRom)
                
                LineMark(
                    x: .value("Date", log.timestamp),
                    y: .value("Tartness", log.tartness)
                )
                .foregroundStyle(Color.orange)
                .interpolationMethod(.catmullRom)
                
                PointMark(
                    x: .value("Date", log.timestamp),
                    y: .value("Sweetness", log.sweetness)
                )
                .foregroundStyle(Color.blue)
                
                PointMark(
                    x: .value("Date", log.timestamp),
                    y: .value("Tartness", log.tartness)
                )
                .foregroundStyle(Color.orange)
            }
        }
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
            //acidityNotes: nil,
            offNotes: nil,
            texture: nil,
            scobyReady: nil
        )
    ])
} 
