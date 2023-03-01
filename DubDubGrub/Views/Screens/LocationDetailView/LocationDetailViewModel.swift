//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 3/1/23.
//

import MapKit
import SwiftUI

final class LocationDetailViewModel: ObservableObject {

    @Published var alertItem: AlertItem?
    @Published var isShowingProfileModal = false

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
}
