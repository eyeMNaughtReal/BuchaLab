import SwiftUI

struct ManagementView: View {
    @State private var brews: [Brew] = [
        Brew(
            name: "First Fermentation Batch",
            startDate: Date().addingTimeInterval(-3 * 24 * 3600),
            scobyId: "1",
            waterAmount: 32,
            sugarAmount: 4,
            starterAmount: 4,
            teaType: .black,
            teaBags: 4,
            phase: .firstFermentation
        ),
        Brew(
            name: "Very Berry",
            startDate: Date().addingTimeInterval(-8 * 24 * 3600),
            scobyId: "1",
            waterAmount: 32,
            sugarAmount: 4,
            starterAmount: 4,
            teaType: .black,
            teaBags: 4,
            phase: .secondFermentation,
            flavors: ["Strawberry", "Raspberry", "Blueberry"]
        )
    ]
    
    @State private var scobys: [SCOBY] = [
        SCOBY(
            id: UUID(),
            name: "SCOBY 1",
            startDate: Date().addingTimeInterval(-30 * 24 * 3600),
            sourceType: .starter,
            sourceName: "Original Starter",
            teaType: .black,
            customTea: nil,
            isLooseLeaf: false,
            teaAmount: 1,
            waterAmount: 16,
            sugarAmount: 1,
            starterAmount: 8
        ),
        SCOBY(
            id: UUID(),
            name: "SCOBY 2",
            startDate: Date().addingTimeInterval(-15 * 24 * 3600),
            sourceType: .mother,
            sourceName: "SCOBY 1",
            teaType: .black,
            customTea: nil,
            isLooseLeaf: false,
            teaAmount: 1,
            waterAmount: 16,
            sugarAmount: 1,
            starterAmount: 8
        )
    ]
    
    var body: some View {
        NavigationStack {
            List {
                // SCOBYs Section
                Section {
                    ForEach($scobys) { $scoby in
                        NavigationLink {
                            SCOBYDetailsView(scoby: $scoby)
                        } label: {
                            Text(scoby.name)
                        }
                    }
                } header: {
                    Text("SCOBYs")
                }
                
                // Brews Section
                Section {
                    ForEach($brews) { $brew in
                        NavigationLink {
                            BrewDetailsView(brew: $brew)
                        } label: {
                            Text(brew.name)
                        }
                    }
                } header: {
                    Text("Brews")
                }
            }
            .navigationTitle("Management")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("New Brew") {
                            // Show NewBrewView
                        }
                        Button("New SCOBY") {
                            // Show NewSCOBYView
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ManagementView()
}

extension View {
    func listSectionStyle(_ style: some ListStyle) -> some View {
        self.listStyle(style)
            .listRowBackground(Color.white.opacity(0.8))
    }
}
