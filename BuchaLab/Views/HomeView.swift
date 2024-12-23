//
//  HomeView.swift
//  BuchaLab
//
//  Created by Mark Conley on 11/23/24.
//

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
        .tint(.blue)
        .onAppear(perform: configureTabBar)
        .background(
            Color(.systemBackground)
                .ignoresSafeArea()
        )
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
    
    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = nil
        appearance.shadowColor = nil
        
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            SCOBYCard(
                                scobyName: "Hotel SCOBY",
                                daysActive: 1,
                                currentTemp: 72.3,
                                currentPH: 3.2
                            )
                            SCOBYCard(
                                scobyName: "New SCOBY",
                                daysActive: 12,
                                currentTemp: 71.5,
                                currentPH: 3.0
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 24)
                    
                    // Active Brews Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            BrewCard(
                                brewName: "First Fermentation Batch",
                                daysInPhase: 3,
                                brewPhase: .firstFermentation,
                                currentTemp: 72.0,
                                currentPH: 3.2
                            )
                            BrewCard(
                                brewName: "Very Berry",
                                daysInPhase: 5,
                                brewPhase: .secondFermentation,
                                currentTemp: 70.4,
                                currentPH: 3.1
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                }
                .padding(.vertical)
            }
            .background(.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
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
            .toolbarBackground(.blue, for: .navigationBar)
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
