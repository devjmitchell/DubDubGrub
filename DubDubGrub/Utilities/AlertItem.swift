//
//  AlertItem.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 2/22/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {

    // MARK: - MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                                message: Text("Unable to retrieve locations at this time.\nPlease try again."),
                                                dismissButton: .default(Text("Ok")))

    static let locationRestricted = AlertItem(title: Text("Locations Restricted"),
                                              message: Text("Your location is restricted. This may be due to parental controls."),
                                              dismissButton: .default(Text("Ok")))

    static let locationDenied = AlertItem(title: Text("Locations Denied"),
                                          message: Text("Dub Dub Grub does not have permission to access your location. To change that go to your phone's Settings > Dub Dub Grub > Location"),
                                          dismissButton: .default(Text("Ok")))

    static let locationDisabled = AlertItem(title: Text("Locations Service Disabled"),
                                            message: Text("Your phone's location services are disabled. To change that go to your phone's Settings > Privacy > Location Services"),
                                            dismissButton: .default(Text("Ok")))
}
