import Foundation

struct Brew: Identifiable {
    let id: UUID
    let name: String
    let startDate: Date
    let scobyId: String
    
    // Brew Configuration
    let waterAmount: Int  // in quarters (4 quarters = 1 cup)
    let sugarAmount: Int  // in quarters
    let starterAmount: Int // in quarters
    let teaType: TeaType
    let customTea: String?
    let teaBags: Int
    let isLooseLeaf: Bool
    
    // Current State
    private(set) var phase: FermentationPhase
    var daysInPhase: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
    }
    private(set) var flavors: [String]?
    var notes: String?
    
    // Monitoring Data
    private(set) var logEntries: [LogEntry]
    private(set) var tasteLogs: [TasteLog]
    
    init(
        id: UUID = UUID(),
        name: String,
        startDate: Date = Date(),
        scobyId: String,
        waterAmount: Int = 32,  // Default 8 cups
        sugarAmount: Int = 4,   // Default 1 cup
        starterAmount: Int = 4, // Default 1 cup
        teaType: TeaType = .black,
        customTea: String? = nil,
        teaBags: Int = 4,
        isLooseLeaf: Bool = false,
        phase: FermentationPhase = .firstFermentation,
        flavors: [String]? = nil,
        notes: String? = nil,
        logEntries: [LogEntry] = [],
        tasteLogs: [TasteLog] = []
    ) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.scobyId = scobyId
        self.waterAmount = waterAmount
        self.sugarAmount = sugarAmount
        self.starterAmount = starterAmount
        self.teaType = teaType
        self.customTea = customTea
        self.teaBags = teaBags
        self.isLooseLeaf = isLooseLeaf
        self.phase = phase
        self.flavors = flavors
        self.notes = notes
        self.logEntries = logEntries
        self.tasteLogs = tasteLogs
    }
    
    // Mutating methods
    mutating func updatePhase(_ newPhase: FermentationPhase) {
        self.phase = newPhase
    }
    
    mutating func addLogEntry(_ entry: LogEntry) {
        self.logEntries.append(entry)
    }
    
    mutating func addTasteLog(_ log: TasteLog) {
        self.tasteLogs.append(log)
    }
    
    mutating func updateFlavors(_ newFlavors: [String]) {
        self.flavors = newFlavors
    }
}

extension Brew {
    enum TeaType: String, CaseIterable {
        case black = "Black Tea"
        case green = "Green Tea"
        case mixed = "Mixed (Black & Green)"
        case custom = "Custom"
    }
} 