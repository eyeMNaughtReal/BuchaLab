import SwiftUI

struct SCOBYCard: View {
    var scobyName: String
    var daysActive: Int
    @State var currentTemp: Double
    @State var currentPH: Double
    @State private var logEntries: [LogEntry] = []
    @State private var tasteLogs: [TasteLog] = []
    
    var body: some View {
        MonitoringCard(
            headerContent: {
                VStack(alignment: .leading, spacing: 8) {
                    Text(scobyName)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text("Fermentation")
                        .font(.subheadline)
                    //Text(daysActive == 1 ? Text(daysActive) " day") : Text(daysActive) " days"))
                    //Text("Fermenting \(daysActive) days")
                    Text("\(daysActive) \(daysActive == 1 ? "day" : "days")")

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
