import SwiftUI

struct HomeViews: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {  // Increased spacing between sections
                    // Section for SCOBYs
                    VStack {
                        HStack {
                            Text("New SCOBYs")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            // Link to "All SCOBYs"
                            NavigationLink(destination: AllSCOBYsView()) {
                                Text("All SCOBYs")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .padding(5)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Horizontal scrolling carousel for SCOBYs
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
                                ForEach(0..<4) { _ in
                                    SCOBYsCard()  // New SCOBY card view
                                        .frame(width: 200, height: 250)  // Adjusted size for better fit
                                        .padding(.leading, 10)
                                        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 1, y: 1)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Section for Brews
                    VStack {
                        HStack {
                            Text("Active Brews")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            // Link to "All Brews"
                            NavigationLink(destination: AllBrewsView()) {
                                Text("All Brews")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .padding(5)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Horizontal scrolling carousel for Brews
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
                                ForEach(0..<4) { _ in
                                    BrewsCard()  // Updated Brews card view
                                        .frame(width: 200, height: 250)  // Adjusted size for better fit
                                        .padding(.leading, 10)
                                        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 1, y: 1)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 20)  // Added bottom padding for spacing
            }
        }
    }
}

struct AllSCOBYsView: View {
    var body: some View {
        Text("All SCOBYs View")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct AllBrewsView: View {
    var body: some View {
        Text("All Brews View")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct HomeViews_Previews: PreviewProvider {
    static var previews: some View {
        HomeViews()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
