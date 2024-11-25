import SwiftUI
import Charts

struct SCOBYDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingNewTasteLog = false
    @State private var showingPHLogger = false
    @State private var showingTempLogger = false
    
    @Binding var scoby: SCOBY
    
    private var latestPH: Double? {
        scoby.logEntries.filter { $0.type == .ph }.last?.value
    }
    
    private var latestTemperature: Double? {
        scoby.logEntries.filter { $0.type == .temperature }.last?.value
    }
    
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                Button {
                    showingNewTasteLog = true
                } label: {
                    Label("Add Taste Log", systemImage: "plus")
                }
                
                Button {
                    showingPHLogger = true
                } label: {
                    Label("Log pH", systemImage: "plus")
                }
                
                Button {
                    showingTempLogger = true
                } label: {
                    Label("Log Temperature", systemImage: "plus")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                StatusSection(phase: .scoby, days: scoby.daysActive)
                MonitoringSection(ph: latestPH, temperature: latestTemperature)
                ChartsSection(logEntries: scoby.logEntries, tasteLogs: scoby.tasteLogs)
            }
        }
        .navigationTitle(scoby.name)
        .toolbar { toolbarContent }
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