import SwiftUI

struct NewBrewView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Basic Info
    @State private var brewName = ""
    @State private var startDate = Date()
    @State private var selectedSCOBYId: String = ""
    
    // Measurements
    @State private var waterAmount = 32 // Default 8 cups (32 quarters)
    @State private var sugarAmount = 4  // Default 1 cup (4 quarters)
    @State private var starterAmount = 4 // Default 1 cup (4 quarters)
    
    // Tea
    @State private var selectedTea = TeaType.black
    @State private var customTea = ""
    @State private var teaBags = 4
    @State private var isLooseLeaf = false
    
    // Temperature monitoring
    @State private var showingInstructions = false
    @State private var notes = ""
    
    // Sample SCOBYs - replace with your actual SCOBY data source
    private var availableScobys: [(id: String, name: String)] = [
        ("1", "SCOBY 1 - Created 10/23/24"),
        ("2", "SCOBY 2 - Created 11/01/24")
    ]
    
    enum TeaType: String, CaseIterable {
        case black = "Black Tea"
        case green = "Green Tea"
        case mixed = "Mixed (Black & Green)"
        case custom = "Other Tea"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                basicInfoSection
                toolsSection
                ingredientsSection
                instructionsButton
                notesSection
            }
            .scrollContentBackground(.hidden)
            .background(Color.buchaLabTheme.background)
            .navigationTitle("New Brew")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color.buchaLabTheme.primary)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        // TODO: Create new brew
                        dismiss()
                    }
                    .foregroundColor(Color.buchaLabTheme.primary)
                    .disabled(brewName.isEmpty)
                }
            }
            .sheet(isPresented: $showingInstructions) {
                FirstFermentationInstructionsView(
                    waterAmount: waterAmount/4,
                    sugarAmount: sugarAmount/4,
                    teaBags: teaBags,
                    starterAmount: starterAmount/4
                )
            }
        }
    }
}

// MARK: - View Sections
extension NewBrewView {
    private var basicInfoSection: some View {
        Section {
            TextField("Brew Name", text: $brewName)
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            Picker("Select SCOBY", selection: $selectedSCOBYId) {
                Text("Choose a SCOBY").tag("")
                ForEach(availableScobys, id: \.id) { scoby in
                    Text(scoby.name).tag(scoby.id)
                }
            }
        } header: {
            Text("Basic Info")
        }
    }
    
    private var toolsSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("• Clean glass jar (1-gallon size)")
                Text("• Cloth or coffee filter")
                Text("• Rubber band")
                Text("• pH strips (optional)")
                Text("• Clean straw for tasting")
            }
            .foregroundColor(Color.buchaLabTheme.text)
        } header: {
            Text("Required Tools")
        }
    }
    
    private var ingredientsSection: some View {
        Section {
            // Tea Selection
            Picker("Tea Type", selection: $selectedTea) {
                ForEach(TeaType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            
            if selectedTea == .custom {
                TextField("Enter Tea Type", text: $customTea)
            }
            
            Toggle("Use Loose Leaf Tea", isOn: $isLooseLeaf)
            
            Stepper("Tea Amount: \(teaBags) \(isLooseLeaf ? "tsp" : "bag\(teaBags == 1 ? "" : "s")")",
                   value: $teaBags, in: 1...10)
            
            // Measurements
            HStack {
                Text("Water")
                Spacer()
                Picker("", selection: $waterAmount) {
                    ForEach(4...64, id: \.self) { quarters in
                        if quarters % 4 == 0 {
                            Text("\(quarters/4) cup\(quarters == 4 ? "" : "s")").tag(quarters)
                        }
                    }
                }
            }
            
            HStack {
                Text("Sugar")
                Spacer()
                Picker("", selection: $sugarAmount) {
                    ForEach(1...16, id: \.self) { quarters in
                        if quarters % 4 == 0 {
                            Text("\(quarters/4) cup\(quarters == 4 ? "" : "s")").tag(quarters)
                        }
                    }
                }
            }
            
            HStack {
                Text("Starter Liquid")
                Spacer()
                Picker("", selection: $starterAmount) {
                    ForEach(4...16, id: \.self) { quarters in
                        if quarters % 4 == 0 {
                            Text("\(quarters/4) cup\(quarters == 4 ? "" : "s")").tag(quarters)
                        }
                    }
                }
            }
            
        } header: {
            Text("Ingredients")
        } footer: {
            Text("Use filtered or distilled water, free of chlorine")
                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
        }
    }
    
    private var instructionsButton: some View {
        Section {
            Button("View Detailed Instructions") {
                showingInstructions = true
            }
        }
    }
    
    private var notesSection: some View {
        Section {
            TextField("Notes", text: $notes, axis: .vertical)
                .lineLimit(3...6)
        } header: {
            Text("Additional Notes")
        }
    }
}

#Preview {
    NewBrewView()
} 