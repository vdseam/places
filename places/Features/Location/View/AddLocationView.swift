//
//  AddLocationView.swift
//  places
//
//  Created by Vlad Deba on 03/09/2024.
//

import SwiftUI

struct AddLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @FocusState private var isNameFieldFocused: Bool
    var onAdd: (String?, Double, Double) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .focused($isNameFieldFocused)
                        .accessibilityLabel("Name")
                        .accessibilityHint("Enter the name of the location")
                        .accessibilityValue(name)
                    
                    TextField("Latitude", text: $latitude)
                        .keyboardType(.numbersAndPunctuation)
                        .accessibilityLabel("Latitude")
                        .accessibilityHint("Enter the latitude of the location")
                        .accessibilityValue(latitude)
                    
                    TextField("Longitude", text: $longitude)
                        .keyboardType(.numbersAndPunctuation)
                        .accessibilityLabel("Longitude")
                        .accessibilityHint("Enter the longitude of the location")
                        .accessibilityValue(longitude)
                }
            }
            .navigationTitle("Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if let lat = convert(latitude), let long = convert(longitude) {
                            onAdd(name.isEmpty ? nil : name, lat, long)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            print("Invalid latitude or longitude")
                        }
                    }
                    .disabled(!isValidCoordinate)
                    .accessibilityLabel("Submit Button")
                    .accessibilityHint("Submit the new location details")
                    .accessibilityAddTraits(.isButton)
                }
            }
            .onAppear {
                isNameFieldFocused = true
            }
        }
    }
    
    private var isValidCoordinate: Bool {
        guard !latitude.isEmpty && !longitude.isEmpty else { return false }
        guard convert(latitude) != nil && convert(longitude) != nil else { return false }
        return true
    }
    
    private func convert(_ inputWithComma: String) -> Double? {
        let inputWithDot = inputWithComma.replacingOccurrences(of: ",", with: ".")
        return Double(inputWithDot)
    }
}
