import SwiftUI

struct NewSCOBYView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var scobyName = ""
    @State private var startDate = Date()
    @State private var sourceType = SourceType.starter
    @State private var sourceName = ""
    
    // Tea selections
    @State private var selectedTea = TeaType.black
    @State private var customTea = ""
    @State private var isLooseLeaf = false
    @State private var teaAmount = 1 // Number of bags or teaspoons
    
    // Measurements
    @State private var waterAmount = 16 // In quarters (16 = 4 cups)
    @State private var sugarAmount = 1  // 1 quarter = 1/4 cup (changed from 4)
    @State private var starterAmount = 8 // In quarters (8 = 2 cups)
    
    @State private var notes = ""
    @State private var showingInstructions = false
    
    enum SourceType: String, CaseIterable {
        case mother = "Mother SCOBY"
        case starter = "Starter Liquid"
        case purchased = "Purchased"
    }
    
    enum TeaType: String, CaseIterable {
        case black = "Black Tea"
        case green = "Green Tea"
        case custom = "Other Tea"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                basicInfoSection
                toolsSection
                ingredientsSection
                sourceSection
                instructionsButton
                notesSection
            }
            .scrollContentBackground(.hidden)
            .background(Color.buchaLabTheme.background)
            .navigationTitle("New SCOBY")
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
                        // TODO: Create new SCOBY
                        dismiss()
                    }
                    .foregroundColor(Color.buchaLabTheme.primary)
                    .disabled(scobyName.isEmpty)
                }
            }
            .sheet(isPresented: $showingInstructions) {
                InstructionsView(
                    waterAmount: waterAmount/4,  // Convert quarters to cups
                    sugarAmount: sugarAmount     // Pass the raw quarter value
                )
            }
        }
    }
}

// MARK: - View Sections
extension NewSCOBYView {
    private var basicInfoSection: some View {
        Section {
            TextField("SCOBY Name", text: $scobyName)
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
        } header: {
            Text("Basic Info")
        }
    }
    
    private var toolsSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("• Clean glass jar (at least 1 quart)")
                Text("• Breathable cloth or coffee filter")
                Text("• Rubber band")
            }
            .foregroundColor(Color.buchaLabTheme.text)
        } header: {
            Text("Required Tools")
        }
    }
    
    private var ingredientsSection: some View {
        Section {
            teaSection
            measurementsSection
        } header: {
            Text("Ingredients")
        }
    }
    
    private var sourceSection: some View {
        Section {
            Picker("Source Type", selection: $sourceType) {
                ForEach(SourceType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            
            HStack {
                Text("Starter Amount")
                Spacer()
                Picker("", selection: $starterAmount) {
                    ForEach(4...16, id: \.self) { quarters in
                        if quarters % 4 == 0 {
                            Text("\(quarters/4) cup\(quarters == 4 ? "" : "s")").tag(quarters)
                        } else {
                            Text("\(quarters/4) \(quarters % 4)/4 cup\(quarters == 4 ? "" : "s")").tag(quarters)
                        }
                    }
                }
            }
        } header: {
            Text("Source")
        }
    }
    
    private var teaSection: some View {
        Group {
            Picker("Tea Type", selection: $selectedTea) {
                ForEach(TeaType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            
            if selectedTea == .custom {
                TextField("Enter Tea Type", text: $customTea)
            }
            
            Toggle("Use Loose Leaf Tea", isOn: $isLooseLeaf)
            
            Stepper("Amount: \(teaAmount) \(isLooseLeaf ? "tsp" : "bag\(teaAmount == 1 ? "" : "s")")",
                   value: $teaAmount, in: 1...10)
        }
    }
    
    private var measurementsSection: some View {
        Group {
            HStack {
                Text("Water")
                Spacer()
                Picker("", selection: $waterAmount) {
                    ForEach(4...32, id: \.self) { quarters in
                        if quarters % 4 == 0 {
                            Text("\(quarters/4) cups").tag(quarters)
                        } else {
                            Text("\(quarters/4) \(quarters % 4)/4 cups").tag(quarters)
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
                        } else {
                            let wholeNumber = quarters/4
                            let fraction = quarters % 4
                            if wholeNumber == 0 {
                                Text("\(fraction)/4 cup").tag(quarters)
                            } else {
                                Text("\(wholeNumber) \(fraction)/4 cups").tag(quarters)
                            }
                        }
                    }
                }
            }
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
    NewSCOBYView()
} 