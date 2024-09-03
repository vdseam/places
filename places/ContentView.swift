//
//  ContentView.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LocationViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.locations) { location in
                VStack(alignment: .leading) {
                    Text(location.name ?? "Unknown")
                        .font(.headline)
                    
                    Text("Latitude: \(location.lat), Longitude: \(location.long)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Locations")
            .onAppear {
                viewModel.fetchLocations()
            }
        }
    }
}

#Preview {
    ContentView()
}
