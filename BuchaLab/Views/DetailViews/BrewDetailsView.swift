import SwiftUI
import Charts

struct BrewDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingPhaseTransition = false
    @State private var showingNewTasteLog = false
    @State private var showingFlavorSelection = false
    
    @Binding var brew: Brew
    
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
                MonitoringSection(ph: latestPH, temperature: latestTemperature)
                ChartsSection(logEntries: brew.logEntries, tasteLogs: brew.tasteLogs)
            }
        }
        .navigationTitle(brew.name)
        .toolbar {
            toolbarContent
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
        .sheet(isPresented: $showingPhaseTransition) {
            PhaseTransitionView { shouldMoveToSecondFermentation in
                if shouldMoveToSecondFermentation {
                    brew.updatePhase(.secondFermentation)
                    showingFlavorSelection = true
                }
            }
        }
        .sheet(isPresented: $showingFlavorSelection) {
            FlavorSelectionView(onSave: { selectedFlavors in
                brew.updateFlavors(selectedFlavors)
                dismiss()
            })
        }
    }

    
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                Button {
                    showingNewTasteLog = true
                } label: {
                    Label("Add Taste Log", systemImage: "plus")
                }
                
                if brew.phase == .firstFermentation {
                    Button {
                        showingPhaseTransition = true
                    } label: {
                        Label("Move to 2F", systemImage: "arrow.right.circle")
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
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
