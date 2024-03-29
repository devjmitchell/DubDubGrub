//
//  DubDubGrubApp.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 6/18/21.
//

import SwiftUI

@main
struct DubDubGrubApp: App {

    let locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            AppTabView().environmentObject(locationManager)
        }
    }
}
