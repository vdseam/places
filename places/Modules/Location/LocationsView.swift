//
//  LocationsView.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import SwiftUI

struct LocationsView: View {
    @StateObject private var viewModel = LocationViewModel()
    @State private var showingAddLocationView = false
    
    var body: some View {
        NavigationView {
            List(viewModel.locations) { location in
                if let url = URL(string: "wikipedia://") {
                    Link(destination: url) {
                        VStack(alignment: .leading) {
                            Text(location.name ?? "Unknown")
                                .font(.headline)
                                .accessibilityLabel(location.name ?? "Unknown")
                                .accessibilityHint("Name of the location")
                            
                            Text("Latitude: \(location.lat), Longitude: \(location.long)")
                                .font(.subheadline)
                                .accessibilityLabel("Latitude: \(location.lat), Longitude: \(location.long)")
                                .accessibilityHint("Shows the geographic coordinates")
                                .foregroundStyle(.secondary)
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isStaticText)
                    }
                    .tint(.primary)
                }
            }
            .navigationTitle("Locations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddLocationView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddLocationView) {
                AddLocationView { name, lat, long in
                    viewModel.addLocation(name: name, lat: lat, long: long)
                }
            }
            .onAppear {
                viewModel.fetchLocations()
            }
        }
    }
}

#Preview {
    LocationsView()
}
