//
//  HomeView.swift
//  BuchaLab
//
//  Created by Mark Conley on 11/23/24.
//
//import SwiftUI

//struct HomeScreen: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import SwiftUI

struct HomeView: View {
    @State private var showingNewSCOBY = false
    @State private var showingSettings = false
    
    var body: some View {
        TabView {
            HomeContentView()  // Separate view for home content
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ManagementView()
                .tabItem {
                    Label("Management", systemImage: "list.bullet.clipboard.fill")
                }
            
            AnalyticsView()
                .tabItem {
                    Label("Analytics", systemImage: "chart.bar.fill")
                }
            
            ArchiveView()
                .tabItem {
                    Label("Archive", systemImage: "archivebox.fill")
                }
        }
        .tint(Color.buchaLabTheme.primary)
        .onAppear(perform: configureTabBar)
        .background(
            Color.buchaLabTheme.surface
                .padding(.top, 8)
                .ignoresSafeArea(edges: .bottom)
        )
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
    
    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.buchaLabTheme.surface)
        appearance.backgroundEffect = nil
        appearance.shadowColor = nil
        
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.buchaLabTheme.text.opacity(0.7))
    }
}

struct HomeContentView: View {
    @State private var showingSettings = false
    @State private var showingNewSCOBY = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // SCOBYs Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("SCOBYs")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.buchaLabTheme.text)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        VStack(spacing: 12) {
                            SCOBYCard(
                                scobyName: "Hotel SCOBY",
                                daysActive: 45,
                                currentTemp: 72,
                                currentPH: 3.2
                            )
                            SCOBYCard(
                                scobyName: "New SCOBY",
                                daysActive: 12,
                                currentTemp: 71,
                                currentPH: 3.0
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 24)
                    
                    // Active Brews Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Active Brews")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.buchaLabTheme.text)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        VStack(spacing: 12) {
                            BrewCard(
                                brewName: "First Fermentation Batch",
                                daysInPhase: 3,
                                brewPhase: .firstFermentation,
                                currentTemp: 72,
                                currentPH: 3.2,
                                flavors: nil
                            )
                            BrewCard(
                                brewName: "Very Berry",
                                daysInPhase: 5,
                                brewPhase: .secondFermentation,
                                currentTemp: 70,
                                currentPH: 3.1,
                                flavors: ["Strawberry", "Raspberry", "Blueberry"]
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                }
                .padding(.vertical)
            }
            .background(Color.buchaLabTheme.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("BuchaLab")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        // New Item Button
                        Button {
                            showingNewSCOBY = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        
                        // Settings Button
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "person.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .toolbarBackground(Color.buchaLabTheme.primary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .confirmationDialog(
                "Create New",
                isPresented: $showingNewSCOBY,
                titleVisibility: .visible
            ) {
                Button("New Brew") {
                    // Navigate to new brew creation
                    print("Create new brew")
                }
                
                Button("New SCOBY") {
                    // Navigate to new SCOBY creation
                    print("Create new SCOBY")
                }
                
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("What would you like to create?")
            }
        }
    }
}

struct SCOBYCard: View {
    var scobyName: String
    var daysActive: Int
    @State var currentTemp: Double
    @State var currentPH: Double
    @State private var showingPHLogger = false
    @State private var showingTempLogger = false
    @State private var showingTasteLogger = false
    @State private var logEntries: [LogEntry] = []
    @State private var tasteLogs: [TasteLog] = []
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 16) {
                // Left Side - SCOBY Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(scobyName)
                        .font(.headline)
                        .foregroundColor(Color.buchaLabTheme.text)
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                        Text("\(daysActive) Days Active")
                            .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                    }
                    .font(.subheadline)
                    
                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Image(systemName: "thermometer")
                                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                            Text(String(format: "%.0f°", currentTemp))
                                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "drop.fill")
                                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                            Text(String(format: "%.1f", currentPH))
                                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                        }
                    }
                    .font(.subheadline)
                }
                
                Spacer()
                
                // Right Side - Quick Actions
                VStack(spacing: 2) {
                    QuickActionButton(
                        label: "Log Temp",
                        color: .blue
                    ) {
                        showingTempLogger = true
                    }
                    
                    QuickActionButton(
                        label: "Log pH",
                        color: .indigo
                    ) {
                        showingPHLogger = true
                    }
                    
                    QuickActionButton(
                        label: "Log Taste",
                        color: .orange
                    ) {
                        showingTasteLogger = true
                    }
                }
            }
            .padding()
        }
        .background(Color.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showingPHLogger) {
            LogPHView { entry in
                logEntries.append(entry)
                currentPH = entry.value
            }
        }
        .sheet(isPresented: $showingTempLogger) {
            LogTemperatureView { entry in
                logEntries.append(entry)
                currentTemp = entry.value
            }
        }
        .sheet(isPresented: $showingTasteLogger) {
            LogTasteView(
                phase: nil,
                onSave: { log in
                    tasteLogs.append(log)
                },
                onPhaseChange: nil
            )
        }
    }
}

struct BrewCard: View {
    var brewName: String
    var daysInPhase: Int
    @State var brewPhase: FermentationPhase
    @State var currentTemp: Double
    @State var currentPH: Double
    var flavors: [String]?
    @State private var showingPHLogger = false
    @State private var showingTempLogger = false
    @State private var showingTasteLogger = false
    @State private var logEntries: [LogEntry] = []
    @State private var tasteLogs: [TasteLog] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Section
            HStack(alignment: .top, spacing: 16) {
                // Left Side - Brew Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(brewName)
                        .font(.headline)
                        .foregroundColor(Color.buchaLabTheme.text)
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                        Text("\(daysInPhase) Days in \(brewPhase.rawValue)")
                            .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                    }
                    .font(.subheadline)
                    
                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Image(systemName: "thermometer")
                                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                            Text(String(format: "%.0f°", currentTemp))
                                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "drop.fill")
                                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                            Text(String(format: "%.1f", currentPH))
                                .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                        }
                    }
                    .font(.subheadline)
                }
                
                Spacer()
                
                // Right Side - Quick Actions
                VStack(spacing: 2) {
                    QuickActionButton(
                        label: "Log Temp",
                        color: .blue
                    ) {
                        showingTempLogger = true
                    }
                    
                    QuickActionButton(
                        label: "Log pH",
                        color: .indigo
                    ) {
                        showingPHLogger = true
                    }
                    
                    QuickActionButton(
                        label: "Log Taste",
                        color: .orange
                    ) {
                        showingTasteLogger = true
                    }
                }
            }
            .padding()
            
            // Bottom Section - Flavors (only for 2F)
            if case .secondFermentation = brewPhase, let flavors = flavors, !flavors.isEmpty {
                Divider()
                    .background(Color.buchaLabTheme.text.opacity(0.2))
                
                Text(flavors.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(Color.buchaLabTheme.text.opacity(0.7))
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
            }
        }
        .background(Color.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showingPHLogger) {
            LogPHView { entry in
                logEntries.append(entry)
                currentPH = entry.value
            }
        }
        .sheet(isPresented: $showingTempLogger) {
            LogTemperatureView { entry in
                logEntries.append(entry)
                currentTemp = entry.value
            }
        }
        .sheet(isPresented: $showingTasteLogger) {
            LogTasteView(
                phase: nil,
                onSave: { log in
                    tasteLogs.append(log)
                },
                onPhaseChange: nil
            )
        }
    }
}

struct QuickActionButton: View {
    let label: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.subheadline)
                .frame(width: 100, alignment: .leading)
        }
        .buttonStyle(.bordered)
        .tint(color)
    }
}

struct ActionButton: View {
    var icon: String
    var label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .frame(width: 60, height: 60)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundColor(.white)
            
            Text(label)
                .font(.callout)
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    HomeView()
}
