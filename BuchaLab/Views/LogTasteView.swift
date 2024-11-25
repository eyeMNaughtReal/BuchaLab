import SwiftUI

struct LogTasteView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = LogTasteViewModel()
    
    let phase: FermentationPhase?
    let onSave: (TasteLog) -> Void
    let onPhaseChange: (() -> Void)?
    
    var body: some View {
        NavigationStack {
            Form {
                // Common Section
                Section("Basic Taste") {
                    RatingRow(label: "Sweetness", value: $viewModel.sweetness)
                    RatingRow(label: "Tartness", value: $viewModel.tartness)
                }
                
                // Phase-specific sections
                if let phase = phase {
                    switch phase {
                    case .firstFermentation:
                        firstFermentationSection
                    case .secondFermentation:
                        secondFermentationSection
                    case .scoby:
                        scobySection
                    case .completed:
                        EmptyView()
                    }
                }
                
                // Notes Section
                Section("Additional Notes") {
                    TextField("Notes", text: $viewModel.comments, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Log Taste")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(viewModel.createTasteLog(phase: phase))
                        dismiss()
                    }
                }
            }
        }
    }
    
    // Phase-specific sections from NewTasteLogView
    private var firstFermentationSection: some View {
        Section("First Fermentation") {
            Picker("Acidity Level", selection: $viewModel.acidity) {
                ForEach(TasteLog.AcidityLevel.allCases) { level in
                    Text(level.rawValue).tag(level)
                }
            }
            Toggle("Ready for Bottling?", isOn: $viewModel.readyForBottling)
        }
    }
    
    private var secondFermentationSection: some View {
        Section("Second Fermentation") {
            RatingRow(label: "Carbonation", value: $viewModel.carbonation)
            RatingRow(label: "Flavor Strength", value: $viewModel.flavorStrength)
            TextField("Added Flavors", text: $viewModel.addedFlavor)
            Toggle("Batch Ready?", isOn: $viewModel.batchReady)
        }
    }
    
    private var scobySection: some View {
        Section("SCOBY Health") {
            TextField("Acidity Notes", text: $viewModel.acidityNotes)
            TextField("Off Notes", text: $viewModel.offNotes)
            TextField("Texture", text: $viewModel.texture)
            Toggle("SCOBY Ready?", isOn: $viewModel.scobyReady)
        }
    }
} 