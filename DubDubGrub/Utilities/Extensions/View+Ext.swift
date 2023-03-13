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


    func embedInScrollView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                self.frame(minHeight: geometry.size.height, maxHeight: .infinity)
            }
        }
    }
}
