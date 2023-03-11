//
//  AppTabViewModel.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 3/6/23.
//

import SwiftUI

extension AppTabView {

    final class AppTabViewModel: ObservableObject {
        @Published var isShowingOnboardView = false
        @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
            didSet { isShowingOnboardView = hasSeenOnboardView }
        }

        let kHasSeenOnboardView = "hasSeenOnboardView"


        func checkIfHasSeenOnboard() {
            if !hasSeenOnboardView { hasSeenOnboardView = true }
        }
    }
}
