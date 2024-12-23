import SwiftUI

struct BrewCard: View {
    var brewName: String
    var daysInPhase: Int
    @State var brewPhase: FermentationPhase
    @State var currentTemp: Double
    @State var currentPH: Double
    @State private var logEntries: [LogEntry] = []
    @State private var tasteLogs: [TasteLog] = []
    
    var body: some View {
        MonitoringCard(
            headerContent: {
                VStack(alignment: .leading, spacing: 8) {
                    Text(brewName)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Text("\(brewPhase.rawValue) day \(daysInPhase)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        
                }
            },
            currentTemp: currentTemp,
            currentPH: currentPH,
            onTempLog: { entry in
                logEntries.append(entry)
                currentTemp = entry.value
            },
            onPHLog: { entry in
                logEntries.append(entry)
                currentPH = entry.value
            },
            onTasteLog: { log in
                tasteLogs.append(log)
            }
        )
    }
} 
