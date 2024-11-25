import Foundation

struct SCOBY: Identifiable {
    let id: UUID
    let name: String
    let startDate: Date
    let sourceType: SourceType
    let sourceName: String?
    
    // Tea Configuration
    let teaType: TeaType
    let customTea: String?
    let isLooseLeaf: Bool
    let teaAmount: Int
    
    // Measurements
    let waterAmount: Int  // in quarters (4 quarters = 1 cup)
    let sugarAmount: Int  // in quarters
    let starterAmount: Int // in quarters
    
    // Current State
    var notes: String?
    var daysActive: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
    }
    
    // Monitoring Data
    private(set) var logEntries: [LogEntry] = []
    private(set) var tasteLogs: [TasteLog] = []
    
    // Mutating methods
    mutating func addLogEntry(_ entry: LogEntry) {
        logEntries.append(entry)
    }
    
    mutating func addTasteLog(_ log: TasteLog) {
        tasteLogs.append(log)
    }
}

// MARK: - Type Definitions
extension SCOBY {
    enum SourceType: String, Codable, CaseIterable {
        case mother = "Mother SCOBY"
        case starter = "Starter Liquid"
        case purchased = "Purchased"
    }
    
    enum TeaType: String, Codable, CaseIterable {
        case black = "Black Tea"
        case green = "Green Tea"
        case custom = "Other Tea"
    }
} 