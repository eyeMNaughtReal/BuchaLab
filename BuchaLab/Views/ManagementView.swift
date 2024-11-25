import SwiftUI

struct SCOBYsSection: View {
    var scobys: [String]
    
    private let sampleLogEntries: [LogEntry] = [
        LogEntry(type: .temperature, value: 72.0),
        LogEntry(type: .ph, value: 3.2)
    ]
    
    var body: some View {
        Section {
            ForEach(scobys, id: \.self) { scoby in
                NavigationLink {
                    SCOBYDetailsView(scoby: .constant(SCOBY(
                        id: UUID(),
                        name: scoby,
                        startDate: Date(),
                        sourceType: .starter,
                        sourceName: nil,
                        teaType: .black,
                        customTea: nil,
                        isLooseLeaf: false,
                        teaAmount: 4,
                        waterAmount: 32,
                        sugarAmount: 4,
                        starterAmount: 4
                    )))
                } label: {
                    Text(scoby)
                        .foregroundColor(Color.buchaLabTheme.text)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        // Handle delete
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        } header: {
            Text("SCOBYs")
                .foregroundColor(Color.buchaLabTheme.text)
                .fontWeight(.bold)
        } footer: {
            Text("Track the health and creation dates of your SCOBYs")
                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
        }
    }
}

struct ManagementView: View {
    @State private var showingNewSCOBY = false
    @State private var showingNewBrew = false
    
    // Test data
    private let displayedScobys = ["Green Tea SCOBY", "Black Tea SCOBY", "Mixed Tea SCOBY"]
    private let displayedBrews = ["Ginger Brew F1", "Berry Blast F2", "Classic Black F1"]
    private let displayedFlavors = ["Ginger & Lemon", "Mixed Berry", "Lavender", "Mint", "Peach"]
    
    private let sampleLogEntries: [LogEntry] = [
        LogEntry(type: .temperature, value: 72.0),
        LogEntry(type: .ph, value: 3.2),
        LogEntry(type: .temperature, value: 74.0),
        LogEntry(type: .ph, value: 3.0)
    ]
    
    private let sampleTasteLogs: [TasteLog] = [
        TasteLog(
            timestamp: Date(),
            sweetness: 3,
            tartness: 4,
            comments: "Nice balance of flavors",
            phase: .firstFermentation,
            acidity: .balanced,
            readyForBottling: false,
            carbonation: nil,
            flavorStrength: nil,
            addedFlavor: nil,
            batchReady: nil,
            acidityNotes: nil,
            offNotes: nil,
            texture: nil,
            scobyReady: nil
        )
    ]
    
    // Test SCOBY with monitoring data
    private var testSCOBY: SCOBY {
        var scoby = SCOBY(
            id: UUID(),
            name: "Test SCOBY",
            startDate: Calendar.current.date(byAdding: .day, value: -30, to: Date())!,
            sourceType: .starter,
            sourceName: nil,
            teaType: .black,
            customTea: nil,
            isLooseLeaf: false,
            teaAmount: 4,
            waterAmount: 32,
            sugarAmount: 4,
            starterAmount: 4
        )
        
        // Add temperature logs (targeting 68-75°F)
        let tempLogs: [LogEntry] = [
            LogEntry(type: .temperature, value: 70.0),
            LogEntry(type: .temperature, value: 72.5),
            LogEntry(type: .temperature, value: 71.0),
            LogEntry(type: .temperature, value: 73.0),
            LogEntry(type: .temperature, value: 69.5),
            LogEntry(type: .temperature, value: 74.0)
        ]
        
        // Add pH logs (targeting 2.5-3.5)
        let phLogs: [LogEntry] = [
            LogEntry(type: .ph, value: 3.4),
            LogEntry(type: .ph, value: 3.2),
            LogEntry(type: .ph, value: 3.0),
            LogEntry(type: .ph, value: 2.8),
            LogEntry(type: .ph, value: 2.7),
            LogEntry(type: .ph, value: 2.6)
        ]
        
        // Add taste logs
        let tasteLogs: [TasteLog] = [
            TasteLog(
                timestamp: Date().addingTimeInterval(-86400 * 5),
                sweetness: 4,
                tartness: 2,
                comments: "Healthy growth, good texture",
                phase: .scoby,
                acidity: nil,
                readyForBottling: nil,
                carbonation: nil,
                flavorStrength: nil,
                addedFlavor: nil,
                batchReady: nil,
                acidityNotes: "Good acidity development",
                offNotes: "None",
                texture: "Firm and healthy",
                scobyReady: true
            ),
            TasteLog(
                timestamp: Date(),
                sweetness: 3,
                tartness: 3,
                comments: "Perfect balance",
                phase: .scoby,
                acidity: nil,
                readyForBottling: nil,
                carbonation: nil,
                flavorStrength: nil,
                addedFlavor: nil,
                batchReady: nil,
                acidityNotes: "Ideal acidity",
                offNotes: "None",
                texture: "Thick and healthy",
                scobyReady: true
            )
        ]
        
        // Add all logs to SCOBY
        tempLogs.forEach { scoby.addLogEntry($0) }
        phLogs.forEach { scoby.addLogEntry($0) }
        tasteLogs.forEach { scoby.addTasteLog($0) }
        
        return scoby
    }
    
    // Test Brew with monitoring data
    private var testBrew: Brew {
        var brew = Brew(
            id: UUID(),
            name: "Test Brew",
            startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
            scobyId: "1",
            teaType: .black,
            customTea: nil,
            teaBags: 4,
            isLooseLeaf: false
        )
        
        // Add temperature logs (targeting 68-75°F)
        let tempLogs: [LogEntry] = [
            LogEntry(type: .temperature, value: 69.0),
            LogEntry(type: .temperature, value: 71.5),
            LogEntry(type: .temperature, value: 73.0),
            LogEntry(type: .temperature, value: 72.0),
            LogEntry(type: .temperature, value: 70.5),
            LogEntry(type: .temperature, value: 71.0)
        ]
        
        // Add pH logs (targeting 2.5-3.5)
        let phLogs: [LogEntry] = [
            LogEntry(type: .ph, value: 3.5),
            LogEntry(type: .ph, value: 3.3),
            LogEntry(type: .ph, value: 3.1),
            LogEntry(type: .ph, value: 2.9),
            LogEntry(type: .ph, value: 2.8),
            LogEntry(type: .ph, value: 2.7)
        ]
        
        // Add taste logs
        let tasteLogs: [TasteLog] = [
            TasteLog(
                timestamp: Date().addingTimeInterval(-86400 * 3),
                sweetness: 4,
                tartness: 2,
                comments: "Still quite sweet",
                phase: .firstFermentation,
                acidity: .tooLow,
                readyForBottling: false,
                carbonation: nil,
                flavorStrength: nil,
                addedFlavor: nil,
                batchReady: nil,
                acidityNotes: nil,
                offNotes: nil,
                texture: nil,
                scobyReady: nil
            ),
            TasteLog(
                timestamp: Date(),
                sweetness: 3,
                tartness: 3,
                comments: "Getting close to ready",
                phase: .firstFermentation,
                acidity: .balanced,
                readyForBottling: true,
                carbonation: nil,
                flavorStrength: nil,
                addedFlavor: nil,
                batchReady: nil,
                acidityNotes: nil,
                offNotes: nil,
                texture: nil,
                scobyReady: nil
            )
        ]
        
        // Add all logs to brew
        tempLogs.forEach { brew.addLogEntry($0) }
        phLogs.forEach { brew.addLogEntry($0) }
        tasteLogs.forEach { brew.addTasteLog($0) }
        
        return brew
    }
    
    var body: some View {
        NavigationStack {
            List {
                SCOBYsSection(scobys: displayedScobys)
                BrewsSection(brews: displayedBrews)
                FlavorsSection(flavors: displayedFlavors)
            }
            .scrollContentBackground(.hidden)
            .background(Color.buchaLabTheme.background)
            .navigationTitle("Management")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingNewSCOBY) {
                NewSCOBYView()
            }
            .sheet(isPresented: $showingNewBrew) {
                NewBrewView()
            }
        }
    }
}

struct BrewsSection: View {
    var brews: [String]
    
    var body: some View {
        Section {
            ForEach(brews, id: \.self) { brew in
                NavigationLink {
                    BrewDetailsView(brew: .constant(Brew(
                        id: UUID(),
                        name: brew,
                        startDate: Date(),
                        scobyId: "1",
                        teaType: .black,
                        customTea: nil,
                        teaBags: 4,
                        isLooseLeaf: false
                    )))
                } label: {
                    Text(brew)
                        .foregroundColor(Color.buchaLabTheme.text)
                }
            }
        } header: {
            Text("Brews")
                .foregroundColor(Color.buchaLabTheme.text)
                .fontWeight(.bold)
        }
    }
}

struct FlavorsSection: View {
    var flavors: [String]
    
    var body: some View {
        Section {
            ForEach(flavors, id: \.self) { flavor in
                Text(flavor)
                    .foregroundColor(Color.buchaLabTheme.text)
            }
        } header: {
            Text("Flavors")
                .foregroundColor(Color.buchaLabTheme.text)
                .fontWeight(.bold)
        }
    }
}
