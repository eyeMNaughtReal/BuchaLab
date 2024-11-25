import SwiftUI

struct NewTasteLogView: View {
    @Environment(\.dismiss) private var dismiss
    let phase: FermentationPhase
    let onSave: (TasteLog) -> Void
    
    @StateObject private var viewModel = LogTasteViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                // Common Section
                Section("Basic Taste") {
                    tasteSlider("Sweetness", value: $viewModel.sweetness)
                    tasteSlider("Tartness", value: $viewModel.tartness)
                }
                
                // Phase-specific sections
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
    
    private func tasteSlider(_ label: String, value: Binding<Int>) -> some View {
        VStack(alignment: .leading) {
            Text(label)
            HStack {
                Text("1")
                Slider(
                    value: Binding(
                        get: { Double(value.wrappedValue) },
                        set: { value.wrappedValue = Int($0) }
                    ),
                    in: 1...5,
                    step: 1
                )
                Text("5")
            }
        }
    }
    
    private var firstFermentationSection: some View {
        Section("First Fermentation") {
            RatingRow(label: "Sweetness", value: $viewModel.sweetness)
            RatingRow(label: "Tartness", value: $viewModel.tartness)
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

#Preview {
    NewTasteLogView(phase: .firstFermentation, onSave: { _ in })
} 
