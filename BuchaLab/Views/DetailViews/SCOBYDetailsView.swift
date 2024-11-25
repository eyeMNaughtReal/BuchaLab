import SwiftUI
import Charts

struct SCOBYDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingNewTasteLog = false
    @State private var showingPHLogger = false
    @State private var showingTempLogger = false
    
    @Binding var scoby: SCOBY
    
    // Test data initialization
    init(scoby: Binding<SCOBY>) {
        self._scoby = scoby
        
        // Add test log entries if empty
        if scoby.wrappedValue.logEntries.isEmpty {
            var testScoby = scoby.wrappedValue
            
            // Add temperature logs over past 7 days
            for i in 0..<7 {
                let entry = LogEntry(
                    type: .temperature,
                    value: Double.random(in: 68...75)
                )
                testScoby.addLogEntry(entry)
            }
            
            // Add pH logs over past 7 days
            for i in 0..<7 {
                let entry = LogEntry(
                    type: .ph,
                    value: Double.random(in: 2.5...3.5)
                )
                testScoby.addLogEntry(entry)
            }
            
            // Add taste logs
            let tasteLogs = [
                TasteLog(
                    timestamp: Date().addingTimeInterval(-86400 * 3),
                    sweetness: 4,
                    tartness: 2,
                    comments: "Healthy growth",
                    phase: .scoby,
                    acidity: nil,
                    readyForBottling: nil,
                    carbonation: nil,
                    flavorStrength: nil,
                    addedFlavor: nil,
                    batchReady: nil,
                    acidityNotes: "Good acidity",
                    offNotes: "None",
                    texture: "Firm",
                    scobyReady: true
                ),
                TasteLog(
                    timestamp: Date(),
                    sweetness: 3,
                    tartness: 3,
                    comments: "Perfect balance",
                    phase: .scoby,
                    acidity: nil,
                    readyForBottling: nil,
                    carbonation: nil,
                    flavorStrength: nil,
                    addedFlavor: nil,
                    batchReady: nil,
                    acidityNotes: "Ideal",
                    offNotes: "None",
                    texture: "Thick",
                    scobyReady: true
                )
            ]
            
            for log in tasteLogs {
                testScoby.addTasteLog(log)
            }
            
            self._scoby = Binding(get: { testScoby }, set: { scoby.wrappedValue = $0 })
        }
    }
    
    private var latestPH: Double? {
        scoby.logEntries.filter { $0.type == .ph }.last?.value
    }
    
    private var latestTemperature: Double? {
        scoby.logEntries.filter { $0.type == .temperature }.last?.value
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                StatusSection(phase: .scoby, days: scoby.daysActive)
                
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
                ChartsSection(logEntries: scoby.logEntries, tasteLogs: scoby.tasteLogs)
            }
        }
        .navigationTitle(scoby.name)
        .sheet(isPresented: $showingNewTasteLog) {
            LogTasteView(
                phase: .scoby,
                onSave: { log in
                    scoby.addTasteLog(log)
                },
                onPhaseChange: nil
            )
        }
        .sheet(isPresented: $showingPHLogger) {
            LogPHView { entry in
                scoby.addLogEntry(entry)
            }
        }
        .sheet(isPresented: $showingTempLogger) {
            LogTemperatureView { entry in
                scoby.addLogEntry(entry)
            }
        }
    }
} 