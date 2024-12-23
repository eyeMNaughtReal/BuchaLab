import SwiftUI

struct MonitoringCard<Header: View>: View {
    var headerContent: Header
    var currentTemp: Double
    var currentPH: Double
    var onTempLog: (LogEntry) -> Void
    var onPHLog: (LogEntry) -> Void
    var onTasteLog: (TasteLog) -> Void
    
    @State private var showingPHLogger = false
    @State private var showingTempLogger = false
    @State private var showingTasteLogger = false
    
    init(
        @ViewBuilder headerContent: () -> Header,
        currentTemp: Double,
        currentPH: Double,
        onTempLog: @escaping (LogEntry) -> Void,
        onPHLog: @escaping (LogEntry) -> Void,
        onTasteLog: @escaping (TasteLog) -> Void
    ) {
        self.headerContent = headerContent()
        self.currentTemp = currentTemp
        self.currentPH = currentPH
        self.onTempLog = onTempLog
        self.onPHLog = onPHLog
        self.onTasteLog = onTasteLog
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerContent
            
            // Measurements
            HStack(spacing: 12) {
                MeasurementButton(
                    icon: "thermometer",
                    value: String(format: "%.1f°", currentTemp),
                    action: { showingTempLogger = true }
                )
                
                MeasurementButton(
                    icon: "drop.fill",
                    value: String(format: "%.1f", currentPH),
                    action: { showingPHLogger = true }
                )
            }
            
            // Action Button
            Button {
                showingTasteLogger = true
            } label: {
                Text("Log Taste")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
            }
            .buttonStyle(.bordered)
            .tint(.blue)
        }
        .padding()
        .frame(width: 160, height: 280)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showingPHLogger) {
            LogPHView { entry in
                onPHLog(entry)
            }
        }
        .sheet(isPresented: $showingTempLogger) {
            LogTemperatureView { entry in
                onTempLog(entry)
            }
        }
        .sheet(isPresented: $showingTasteLogger) {
            LogTasteView(
                phase: nil,
                onSave: onTasteLog,
                onPhaseChange: { }
            )
        }
    }
} 
