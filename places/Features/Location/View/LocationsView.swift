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
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.locations.isEmpty {
                contentUnavailableView
            } else {
                locationsList
            }
        }
        .onAppear {
            viewModel.fetchLocations()
        }
    }
    
    private var locationsList: some View {
        List(viewModel.locations) { location in
            if let url = viewModel.url(for: location) {
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
    }
    
    private var contentUnavailableView: some View {
        ContentUnavailableView {
            Label("No Internet", systemImage: "wifi.exclamationmark")
        } description: {
            Text("Try checking the network cables, modem, and router or reconnecting to Wi-Fi.")
        } actions: {
            Button("Try again") {
                viewModel.fetchLocations()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
        }
    }
}

#Preview {
    LocationsView()
}
