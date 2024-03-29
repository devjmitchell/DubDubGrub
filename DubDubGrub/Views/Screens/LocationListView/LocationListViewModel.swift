//
//  LocationListViewModel.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 3/3/23.
//

import CloudKit
import SwiftUI

extension LocationListView {

    @MainActor final class LocationListViewModel: ObservableObject {
        @Published var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
        @Published var alertItem: AlertItem?


        func getCheckedInProfilesDictionary() async {
            do {
                checkedInProfiles = try await CloudKitManager.shared.getCheckedInProfilesDictionary()
            } catch {
                alertItem = AlertContext.unableToGetAllCheckedInProfiles
            }
        }


        func createVoiceOverSummary(for location: DDGLocation) -> String {
            let count = checkedInProfiles[location.id, default: []].count
            let personPlurality = count == 1 ? "person" : "people"

            return "\(location.name) \(count) \(personPlurality) checked in"
        }


        @ViewBuilder func createLocationDetailView(for location: DDGLocation, in dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize >= .accessibility3 {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location)).embedInScrollView()
            } else {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location))
            }
        }
    }
}
