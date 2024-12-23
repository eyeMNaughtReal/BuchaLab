//
//  BrewsCard.swift
//  BuchaLab
//
//  Created by Mark Conley on 12/13/24.
//

import SwiftUI

struct SCOBYsCard: View {
    var body: some View {
                
        ZStack{
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            VStack {
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("4 days")
                            .font(.headline)
                        
                        Text("New SCOBY")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 8) {
                        Image(systemName: "clock.arrow.trianglehead.2.counterclockwise.rotate.90")
                            .foregroundStyle(.green)
                            .font(.headline)

                    }
                }
                .padding(.bottom)
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("1F") //brewPhase
                        
                        Spacer()
                        Image(systemName: "thermometer.variable")
                        
                        Text("72.4°F") //currentTemp
                        
                        Spacer()
                        
                        Image(systemName: "drop.halffull")
                        
                        Text("3.4") //currentPh
                        
                    }
                    .font(.footnote)
                    .padding(.bottom)

                    Button(action: {
                                // Button action
                                print("Loading LogView")
                            }) {
                                Text("Log Data")
                                    .font(.headline)  // Set font size and style
                                    .foregroundColor(.white)  // Set text color
                                    .padding(.vertical, 5)  // Padding for top and bottom
                                    .padding(.horizontal, 20)  // Padding for left and right
                                    .background(Color.blue)  // Set background color
                                    .cornerRadius(5)  // Make the button corners rounded
                                    .shadow(radius: 5)  // Add shadow to the button
                            }
                    
                    Text("Last updated: 3 days ago") //updateTime
                        .italic()
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.vertical, 5)
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    SCOBYsCard()
}
