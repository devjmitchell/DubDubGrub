//
//  HapticManager.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 3/8/23.
//

import UIKit

struct HapticManager {

    static func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
