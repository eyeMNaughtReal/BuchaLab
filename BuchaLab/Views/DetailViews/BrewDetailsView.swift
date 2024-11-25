import SwiftUI
import Charts

struct BrewDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingPhaseTransition = false
    @State private var showingNewTasteLog = false
    @State private var showingFlavorSelection = false
    @State private var showingPHLogger = false
    @State private var showingTempLogger = false
    
    @Binding var brew: Brew
    
    // Test data initialization
    init(brew: Binding<Brew>) {
        self._brew = brew
        
        // Add test log entries if empty
        if brew.wrappedValue.logEntries.isEmpty {
            var testBrew = brew.wrappedValue
            
            // Add temperature logs over past 7 days
            for i in 0..<7 {
                let entry = LogEntry(
                    type: .temperature,
                    value: Double.random(in: 68...75)
                )
                testBrew.addLogEntry(entry)
            }
            
            // Add pH logs showing fermentation progress
            for i in 0..<7 {
                let entry = LogEntry(
                    type: .ph,
                    value: Double(3.5 - (Double(i) * 0.1))
                )
                testBrew.addLogEntry(entry)
            }
            
            // Add taste logs
            let tasteLogs = [
                TasteLog(
                    timestamp: Date().addingTimeInterval(-86400 * 3),
                    sweetness: 4,
                    tartness: 2,
                    comments: "Still sweet",
                    phase: .firstFermentation,
                    acidity: .tooLow,
                    readyForBottling: false,
                    carbonation: nil,
                    flavorStrength: nil,
                    addedFlavor: nil,
                    batchReady: nil,
                    acidityNotes: nil,
                    offNotes: nil,
                    texture: nil,
                    scobyReady: nil
                ),
                TasteLog(
                    timestamp: Date(),
                    sweetness: 3,
                    tartness: 3,
                    comments: "Ready to bottle",
                    phase: .firstFermentation,
                    acidity: .balanced,
                    readyForBottling: true,
                    carbonation: nil,
                    flavorStrength: nil,
                    addedFlavor: nil,
                    batchReady: nil,
                    acidityNotes: nil,
                    offNotes: nil,
                    texture: nil,
                    scobyReady: nil
                )
            ]
            
            for log in tasteLogs {
                testBrew.addTasteLog(log)
            }
            
            self._brew = Binding(get: { testBrew }, set: { brew.wrappedValue = $0 })
        }
    }
    
    private var latestPH: Double? {
        brew.logEntries.filter { $0.type == .ph }.last?.value
    }
    
    private var latestTemperature: Double? {
        brew.logEntries.filter { $0.type == .temperature }.last?.value
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                StatusSection(phase: brew.phase, days: brew.daysInPhase)
                
                // Quick Action Buttons
                HStack(spacing: 12) {
                    Button(action: { showingTempLogger = true }) {
                        Text("Log Temp")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.orange.opacity(0.2))
                            .foregroundColor(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button(action: { showingPHLogger = true }) {
                        Text("Log pH")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button(action: { showingNewTasteLog = true }) {
                        Text("Log Taste")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal)
                
                MonitoringSection(ph: latestPH, temperature: latestTemperature)
                ChartsSection(logEntries: brew.logEntries, tasteLogs: brew.tasteLogs)
            }
        }
        .navigationTitle(brew.name)
        .sheet(isPresented: $showingPHLogger) {
            LogPHView { entry in
                brew.addLogEntry(entry)
            }
        }
        .sheet(isPresented: $showingTempLogger) {
            LogTemperatureView { entry in
                brew.addLogEntry(entry)
            }
        }
        .sheet(isPresented: $showingNewTasteLog) {
            LogTasteView(
                phase: brew.phase,
                onSave: { log in
                    brew.addTasteLog(log)
                },
                onPhaseChange: {
                    showingPhaseTransition = true
                }
            )
        }
    }
}

// Generic Chart View for metrics
struct MetricChartView: View {
    let title: String
    let data: [LogEntry]
    let valueRange: ClosedRange<Double>
    let valueFormatter: (Double) -> String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.buchaLabTheme.primary)
            
            if data.isEmpty {
                Text("No data recorded yet")
                    .font(.subheadline)
                    .foregroundColor(Color.buchaLabTheme.text)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                Chart(data) { entry in
                    LineMark(
                        x: .value("Date", entry.timestamp),
                        y: .value("Value", entry.value)
                    )
                    .symbol(Circle())
                }
                .chartYScale(domain: valueRange)
                .frame(height: 200)
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
