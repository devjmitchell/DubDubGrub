//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 12/31/21.
//

import SwiftUI

extension View {

    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }


    func playHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }


    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
