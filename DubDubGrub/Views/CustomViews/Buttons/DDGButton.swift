//
//  DDGButton.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 12/31/21.
//

import SwiftUI

struct DDGButton: View {
    var title: String
    var color: Color = .brandPrimary
    
    var body: some View {
        Text(title)
            .bold()
            .frame(width: 280, height: 44)
            .background(color.gradient)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct DDGButton_Previews: PreviewProvider {
    static var previews: some View {
        DDGButton(title: "Test Button")
    }
}
