//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 2/23/23.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
