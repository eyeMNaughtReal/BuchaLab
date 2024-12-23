import SwiftUI

struct FlavorSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
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
                // Basic Info
                Section {
                    DatePicker("Bottling Date", selection: $bottlingDate, displayedComponents: .date)
                }
                
                // Flavor Categories
                flavorCategoriesSection
                
                // Custom Flavor
                customFlavorSection
                
                // Selected Flavors
                if !selectedFlavors.isEmpty {
                    selectedFlavorsSection
                }
                
                // Notes
                notesSection
            }
            .scrollContentBackground(.hidden)
            .background(.background)
            .navigationTitle("2F Flavoring")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var flavorCategoriesSection: some View {
        ForEach(Array(flavorCategories.keys.sorted()), id: \.self) { category in
            Section {
                ForEach(flavorCategories[category] ?? [], id: \.self) { flavor in
                    flavorRow(for: flavor)
                }
            } header: {
                Text(category)
            }
        }
    }
    
    private func flavorRow(for flavor: String) -> some View {
        HStack {
            Button {
                toggleFlavor(flavor)
            } label: {
                HStack {
                    Image(systemName: selectedFlavors.contains(flavor) ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(selectedFlavors.contains(flavor) ? .blue : .secondary)
                    Text(flavor)
                        .foregroundColor(.primary)
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
    
    private var customFlavorSection: some View {
        Section {
            TextField("Custom Flavor", text: $customFlavor)
            Button("Add Custom Flavor") {
                if !customFlavor.isEmpty {
                    selectedFlavors.insert(customFlavor)
                    customFlavor = ""
                }
            }
            .disabled(customFlavor.isEmpty)
        } header: {
            Text("Custom Flavor")
        }
    }
    
    private var selectedFlavorsSection: some View {
        Section {
            ForEach(Array(selectedFlavors), id: \.self) { flavor in
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
    
    private var notesSection: some View {
        Section {
            TextField("Additional notes about flavoring", text: $notes, axis: .vertical)
                .lineLimit(3...6)
        } header: {
            Text("Notes")
        } footer: {
            Text("Add any special instructions or measurements")
        }
    }
}

#Preview {
    FlavorSelectionView()
} 