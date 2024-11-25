import SwiftUI

struct FlavorSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    let onSave: ([String]) -> Void
    
    @State private var selectedFlavors: Set<String> = []
    @State private var customFlavor = ""
    @State private var notes = ""
    @State private var bottlingDate = Date()
    
    // Sample flavor categories and options
    let flavorCategories = [
        "Fruit": [
            "Strawberry",
            "Blueberry",
            "Raspberry",
            "Mango",
            "Peach",
            "Pineapple",
            "Apple",
            "Pear",
            "Cherry"
        ],
        "Herbs & Spices": [
            "Ginger",
            "Mint",
            "Lavender",
            "Rosemary",
            "Turmeric",
            "Cinnamon",
            "Cardamom"
        ],
        "Botanicals": [
            "Hibiscus",
            "Rose",
            "Elderflower",
            "Chamomile",
            "Jasmine"
        ]
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                // Bottling Date
                Section {
                    DatePicker("Bottling Date", selection: $bottlingDate, displayedComponents: .date)
                }
                
                // Flavor Selection
                ForEach(Array(flavorCategories.keys.sorted()), id: \.self) { category in
                    Section {
                        ForEach(flavorCategories[category] ?? [], id: \.self) { flavor in
                            HStack {
                                Button {
                                    toggleFlavor(flavor)
                                } label: {
                                    HStack {
                                        Image(systemName: selectedFlavors.contains(flavor) ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(selectedFlavors.contains(flavor) ? Color.buchaLabTheme.primary : .gray)
                                        Text(flavor)
                                            .foregroundColor(Color.buchaLabTheme.text)
                                    }
                                }
                            }
                        }
                    } header: {
                        Text(category)
                    }
                }
                
                // Custom Flavor
                Section {
                    TextField("Enter custom flavor", text: $customFlavor)
                    if !customFlavor.isEmpty {
                        Button("Add Custom Flavor") {
                            if !customFlavor.isEmpty {
                                selectedFlavors.insert(customFlavor)
                                customFlavor = ""
                            }
                        }
                    }
                } header: {
                    Text("Custom Flavor")
                }
                
                // Selected Flavors
                if !selectedFlavors.isEmpty {
                    Section {
                        ForEach(Array(selectedFlavors).sorted(), id: \.self) { flavor in
                            HStack {
                                Text(flavor)
                                Spacer()
                                Button {
                                    selectedFlavors.remove(flavor)
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    } header: {
                        Text("Selected Flavors")
                    }
                }
                
                // Notes
                Section {
                    TextField("Additional notes about flavoring", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                } header: {
                    Text("Notes")
                } footer: {
                    Text("Add any special instructions or measurements")
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.buchaLabTheme.background)
            .navigationTitle("2F Flavoring")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Begin 2F") {
                        onSave(Array(selectedFlavors))
                        dismiss()
                    }
                    .disabled(selectedFlavors.isEmpty)
                }
            }
        }
    }
    
    private func toggleFlavor(_ flavor: String) {
        if selectedFlavors.contains(flavor) {
            selectedFlavors.remove(flavor)
        } else {
            selectedFlavors.insert(flavor)
        }
    }
}

#Preview {
    FlavorSelectionView(onSave: { _ in })
} 