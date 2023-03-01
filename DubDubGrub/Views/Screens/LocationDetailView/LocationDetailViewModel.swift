//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 3/1/23.
//

import CloudKit
import MapKit
import SwiftUI

enum CheckInStatus { case checkedIn, checkedOut }

final class LocationDetailViewModel: ObservableObject {

    @Published var checkedInProfiles: [DDGProfile] = []
    @Published var isShowingProfileModal = false
    @Published var isCheckedIn = false
    @Published var alertItem: AlertItem?

    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]

    var location: DDGLocation

    init(location: DDGLocation) {
        self.location = location
    }

    func getDirectionsToLocation() {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name

        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }

    func callLocation() {
        guard let url = URL(string: "tel://\(location.phoneNumber)") else {
            alertItem = AlertContext.invalidPhoneNumber
            return
        }

        UIApplication.shared.open(url)
    }

    func updateCheckInStatus(to checkInStatus: CheckInStatus) {

        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            // show an alert
            return
        }

        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
            case .success(let record):
                switch checkInStatus {
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                }

                CloudKitManager.shared.save(record: record) { result in
                    let profile = DDGProfile(record: record)
                    DispatchQueue.main.async {
                        switch result {
                        case .success(_):
                            switch checkInStatus {
                            case .checkedIn:
                                checkedInProfiles.append(profile)
                            case .checkedOut:
                                checkedInProfiles.removeAll(where: { $0.id == profile.id })
                            }

                            isCheckedIn = checkInStatus == .checkedIn

                            print("✅ Checked In/Out Successfully")
                        case .failure(_):
                            print("❌ Error saving record")
                        }
                    }
                }

            case .failure(_):
                print("❌ Error fetching record")
            }
        }
    }

    func getCheckedInProfiles() {
        CloudKitManager.shared.getCheckedInProfiles(for: location.id) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profiles):
                    checkedInProfiles = profiles
                case .failure(_):
                    print("Error fetching checkedIn profiles")
                }
            }
        }
    }
}
