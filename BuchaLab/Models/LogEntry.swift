import Foundation

struct LogEntry: Identifiable, Codable {
    let id: UUID
    let timestamp: Date
    let type: LogType
    let value: Double
    let notes: String?
    
    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        type: LogType,
        value: Double,
        notes: String? = nil
    ) {
        self.id = id
        self.timestamp = timestamp
        self.type = type
        self.value = value
        self.notes = notes
    }
}

// MARK: - LogType
extension LogEntry {
    enum LogType: String, Codable, CaseIterable {
        case ph = "pH"
        case temperature = "Temperature"
        
        var unit: String {
            switch self {
            case .ph:
                return "pH"
            case .temperature:
                return "°F"
            }
        }
        
        var range: ClosedRange<Double> {
            switch self {
            case .ph:
                return 0...14
            case .temperature:
                return 32...120
            }
        }
        
        var idealRange: ClosedRange<Double> {
            switch self {
            case .ph:
                return 2.5...3.5
            case .temperature:
                return 68...78
            }
        }
        
        var chartRange: ClosedRange<Double> {
            switch self {
            case .ph:
                return 2.5...7.0
            case .temperature:
                return 60...85
            }
        }
    }
}